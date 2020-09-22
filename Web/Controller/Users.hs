module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New
import Web.View.Users.Edit
import Web.View.Users.Show
import Web.View.Users.New
import Web.View.Users.Show
import Web.View.Users.Edit

instance Controller UsersController where
    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId
        threads <- user
            |> get #threads
            |> orderByDesc #createdAt
            |> fetch
            >>= collectionFetchRelated #userId
            >>= collectionFetchRelated #topicId
        badges <- query @UserBadge 
            |> filterWhere (#userId, currentUserId) 
            |> fetch
        render ShowView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        accessDeniedUnless (get #id user == currentUserId)
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId
        accessDeniedUnless (get #id user == currentUserId)
        user
            |> fill @["name", "githubName"]
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "User updated"
                    redirectTo EditUserAction { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> fill @["email", "passwordHash", "name", "githubName"]
            |> validateField #email nonEmpty
            |> validateField #passwordHash nonEmpty
            |> validateField #name nonEmpty
            |> ifValid \case
                Left user -> render NewView { .. } 
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "User created"
                    redirectTo TopicsAction

    action DeleteUserAction { userId } = do
        accessDeniedUnless (userId == currentUserId)
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo TopicsAction
