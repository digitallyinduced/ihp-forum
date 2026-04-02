module Web.Controller.Threads where

import Web.Controller.Prelude
import Web.View.Threads.Index
import Web.View.Threads.New
import Web.View.Threads.Edit
import Web.View.Threads.Show

instance Controller ThreadsController where
    action ThreadsAction = do
        threads <- query @Thread
            |> orderByDesc #createdAt
            |> fetch
        let userIds = threads |> map (.userId) |> nub
        let topicIds = threads |> map (.topicId) |> nub
        threadUsers <- query @User |> filterWhereIdIn userIds |> fetch
        threadTopics <- query @Topic |> filterWhereIdIn topicIds |> fetch
        render IndexView { .. }

    action NewThreadAction = do
        ensureIsUser

        let thread = newRecord
        topics <- query @Topic |> fetch
        render NewView { .. }

    action ShowThreadAction { threadId } = do
        thread <- fetch threadId
        author <- fetch thread.userId

        comments <- query @Comment
                |> filterWhere (#threadId, threadId)
                |> orderBy #createdAt
                |> fetch
        let commentUserIds = comments |> map (.userId) |> nub
        commentUsers <- query @User |> filterWhereIdIn commentUserIds |> fetch

        badges <- query @UserBadge |> fetch
        let badgeUserIds = badges |> map (.userId) |> nub
        badgeUsers <- query @User |> filterWhereIdIn badgeUserIds |> fetch

        render ShowView { .. }

    action EditThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (thread.userId == currentUserId)

        topics <- query @Topic |> fetch
        render EditView { .. }

    action UpdateThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (thread.userId == currentUserId)

        thread
            |> buildThread
            |> ifValid \case
                Left thread -> do
                    topics <- query @Topic |> fetch
                    render EditView { .. }
                Right thread -> do
                    thread <- thread |> updateRecord
                    setSuccessMessage "Thread updated"
                    let threadId = thread.id
                    redirectTo ShowThreadAction { threadId }

    action CreateThreadAction = do
        ensureIsUser

        let thread = newRecord @Thread
        thread
            |> buildThread
            |> set #userId currentUserId
            |> ifValid \case
                Left thread -> do
                    topics <- query @Topic |> fetch
                    render NewView { .. }
                Right thread -> do
                    thread <- thread |> createRecord

                    now <- getCurrentTime
                    topic <- fetch thread.topicId
                    topic
                        |> incrementField #threadsCount
                        |> set #lastActivityAt now
                        |> updateRecord

                    sendNewThreadNotification thread

                    let threadId = thread.id
                    redirectTo ShowThreadAction { threadId }

    action DeleteThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (thread.userId == currentUserId)
        deleteRecord thread
        setSuccessMessage "Thread deleted"
        redirectTo ThreadsAction

buildThread thread = thread
    |> fill @["title","body", "topicId"]
    |> validateField #topicId topicIsSelected
    |> validateField #body nonEmpty
    |> validateField #title nonEmpty

topicIsSelected topicId | topicId == def = Failure "Please pick a topic"
topicIsSelected _ = Success

sendNewThreadNotification thread = do
    let title = thread.title
    let url = urlTo ShowThreadAction { threadId = thread.id}
    sendToSlackAsync [trimming|New: $title. $url|]
