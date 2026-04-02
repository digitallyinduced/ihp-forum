module Web.Controller.Comments where

import Web.Controller.Prelude
import IHP.Mail
import Web.View.Comments.New
import Web.View.Comments.Edit
import Web.View.Comments.Show
import Web.Mail.Comments.NewCommentNotification

instance Controller CommentsController where
    beforeAction = ensureIsUser

    action NewCommentAction { threadId } = do
        thread <- fetch threadId
        author <- fetch thread.userId
        let comment = newRecord
                |> set #threadId threadId
        badges <- query @UserBadge |> fetch
        let badgeUserIds = badges |> map (.userId) |> nub
        badgeUsers <- query @User |> filterWhereIdIn badgeUserIds |> fetch
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        thread <- fetch comment.threadId
        author <- fetch thread.userId
        badges <- query @UserBadge |> fetch
        let badgeUserIds = badges |> map (.userId) |> nub
        badgeUsers <- query @User |> filterWhereIdIn badgeUserIds |> fetch
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    thread <- fetch comment.threadId
                    author <- fetch thread.userId
                    badges <- query @UserBadge |> fetch
                    let badgeUserIds = badges |> map (.userId) |> nub
                    badgeUsers <- query @User |> filterWhereIdIn badgeUserIds |> fetch
                    render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    let threadId = comment.threadId
                    redirectTo ShowThreadAction { .. }

    action CreateCommentAction = do
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> fill @'["threadId"]
            |> set #userId currentUserId
            |> ifValid \case
                Left comment -> do
                    thread <- fetch comment.threadId
                    author <- fetch thread.userId
                    badges <- query @UserBadge |> fetch
                    let badgeUserIds = badges |> map (.userId) |> nub
                    badgeUsers <- query @User |> filterWhereIdIn badgeUserIds |> fetch
                    render NewView { .. }
                Right comment -> do
                    comment <- comment |> createRecord

                    now <- getCurrentTime
                    thread <- fetch comment.threadId
                    topic <- fetch thread.topicId
                    topic
                        |> set #lastActivityAt now
                        |> updateRecord

                    sendNewCommentNotification thread
                    sendEmailNotification thread comment

                    redirectTo ShowThreadAction { threadId = comment.threadId }

    action DeleteCommentAction { commentId } = do
        comment <- fetch commentId
        accessDeniedUnless (comment.userId == currentUserId)
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        let threadId = comment.threadId
        redirectTo ShowThreadAction { threadId }

buildComment comment = comment
    |> fill @'["body"]
    |> validateField #body nonEmpty

sendNewCommentNotification thread = do
    let title = thread.title
    let url = urlTo ShowThreadAction { threadId = thread.id}
    sendToSlackAsync [trimming|New Comment on $title. $url|]

sendEmailNotification thread comment = do
    comments <- query @Comment
            |> filterWhere (#threadId, thread.id)
            |> fetch
    let userIds = comments |> map (.userId) |> nub
    usersThatCommented <- query @User
            |> filterWhereIdIn userIds
            |> fetch

    -- https://github.com/digitallyinduced/ihp/issues/1015
    let otherUsersThatCommented = usersThatCommented
            |> filter (\user -> user.id /= currentUserId)

    forEach otherUsersThatCommented \user -> do
        sendMail NewCommentNotificationMail { .. }
