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
        let comment = newRecord
                |> set #threadId threadId
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        thread <- fetch (get #threadId comment)
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    thread <- fetch (get #threadId comment)
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
                    render NewView { .. } 
                Right comment -> do
                    comment <- comment |> createRecord

                    now <- getCurrentTime
                    thread <- fetch (get #threadId comment)
                    topic <- fetch (get #topicId thread)
                    topic
                        |> set #lastActivityAt now
                        |> updateRecord

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
