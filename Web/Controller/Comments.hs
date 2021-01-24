module Web.Controller.Comments where

import Web.Controller.Prelude
import Web.View.Comments.New
import Web.View.Comments.Edit
import Web.View.Comments.Show
import Web.View.Comments.New
import Web.View.Comments.Show
import Web.View.Comments.Edit

instance Controller CommentsController where
    beforeAction = ensureIsUser

    action NewCommentAction { threadId } = do
        thread <- fetch threadId
            >>= fetchRelated #userId
        let comment = newRecord
                |> set #threadId threadId
        badges <- query @UserBadge
            |> fetch
            >>= collectionFetchRelated #userId
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        thread <- fetch (get #threadId comment)
                  >>= fetchRelated #userId
        badges <- query @UserBadge
                  |> fetch
                  >>= collectionFetchRelated #userId
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    thread <- fetch (get #threadId comment)
                              >>= fetchRelated #userId
                    badges <- query @UserBadge
                              |> fetch
                              >>= collectionFetchRelated #userId
                    render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    let threadId = get #threadId comment
                    redirectTo ShowThreadAction { .. }

    action CreateCommentAction = do
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> fill @'["threadId"]
            |> set #userId currentUserId
            |> ifValid \case
                Left comment -> do
                    thread <- fetch (get #threadId comment)
                        >>= fetchRelated #userId
                    badges <- query @UserBadge
                        |> fetch
                        >>= collectionFetchRelated #userId
                    render NewView { .. }
                Right comment -> do
                    comment <- comment |> createRecord

                    now <- getCurrentTime
                    thread <- fetch (get #threadId comment)
                    topic <- fetch (get #topicId thread)
                    topic
                        |> set #lastActivityAt now
                        |> updateRecord

                    sendNewCommentNotification thread

                    redirectTo ShowThreadAction { threadId = get #threadId comment }

    action DeleteCommentAction { commentId } = do
        comment <- fetch commentId
        accessDeniedUnless (get #userId comment == currentUserId)
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        let threadId = get #threadId comment
        redirectTo ShowThreadAction { threadId }

buildComment comment = comment
    |> fill @'["body"]
    |> validateField #body nonEmpty

sendNewCommentNotification thread = do
    let title = get #title thread
    let url = urlTo ShowThreadAction { threadId = get #id thread}
    sendToSlackAsync [text|New Comment on $title. $url|]