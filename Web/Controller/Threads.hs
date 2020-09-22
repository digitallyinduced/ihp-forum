module Web.Controller.Threads where

import Web.Controller.Prelude
import Web.View.Threads.Index
import Web.View.Threads.New
import Web.View.Threads.Edit
import Web.View.Threads.Show
import Web.View.Threads.Index
import Web.View.Threads.New
import Web.View.Threads.Show
import Web.View.Threads.Edit

instance Controller ThreadsController where
    action ThreadsAction = do
        threads <- query @Thread
            |> orderBy #createdAt
            |> fetch
            >>= collectionFetchRelated #userId
            >>= collectionFetchRelated #topicId
        render IndexView { .. }

    action NewThreadAction = do
        ensureIsUser

        let thread = newRecord
        topics <- query @Topic |> fetch
        render NewView { .. }

    action ShowThreadAction { threadId } = do
        thread <- fetch threadId
            >>= fetchRelated #userId
        comments <- thread
                |> get #comments
                |> orderBy #createdAt
                |> fetch
                >>= collectionFetchRelated #userId
        badges <- query @UserBadge 
            |> fetch
            >>= collectionFetchRelated #userId
        render ShowView { .. }

    action EditThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (get #userId thread == currentUserId)

        render EditView { .. }

    action UpdateThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (get #userId thread == currentUserId)
        
        thread
            |> buildThread
            |> ifValid \case
                Left thread -> render EditView { .. }
                Right thread -> do
                    thread <- thread |> updateRecord
                    setSuccessMessage "Thread updated"
                    redirectTo EditThreadAction { .. }

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
                    topic <- fetch (get #topicId thread)
                    topic
                        |> incrementField #threadsCount
                        |> set #lastActivityAt now
                        |> updateRecord

                    let threadId = get #id thread
                    redirectTo ShowThreadAction { threadId }

    action DeleteThreadAction { threadId } = do
        ensureIsUser
        thread <- fetch threadId
        accessDeniedUnless (get #userId thread == currentUserId)
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
