module Admin.Controller.UserBadges where

import Admin.Controller.Prelude
import Admin.View.UserBadges.Index
import Admin.View.UserBadges.New
import Admin.View.UserBadges.Edit
import Admin.View.UserBadges.Show

import Admin.View.UserBadges.Index
import Admin.View.UserBadges.New
import Admin.View.UserBadges.Show
import Admin.View.UserBadges.Edit

instance Controller UserBadgesController where
    action UserBadgesAction = do
        userBadges <- query @UserBadge 
            |> fetch
            >>= collectionFetchRelated #userId
        render IndexView { .. }

    action NewUserBadgeAction = do
        let userBadge = newRecord
        render NewView { .. }

    action ShowUserBadgeAction { userBadgeId } = do
        userBadge <- fetch userBadgeId
        render ShowView { .. }

    action EditUserBadgeAction { userBadgeId } = do
        userBadge <- fetch userBadgeId
        render EditView { .. }

    action UpdateUserBadgeAction { userBadgeId } = do
        userBadge <- fetch userBadgeId
        userBadge
            |> buildUserBadge
            |> ifValid \case
                Left userBadge -> render EditView { .. }
                Right userBadge -> do
                    userBadge <- userBadge |> updateRecord
                    setSuccessMessage "UserBadge updated"
                    redirectTo EditUserBadgeAction { .. }

    action CreateUserBadgeAction = do
        let userBadge = newRecord @UserBadge
        userBadge
            |> buildUserBadge
            |> ifValid \case
                Left userBadge -> render NewView { .. } 
                Right userBadge -> do
                    userBadge <- userBadge |> createRecord
                    setSuccessMessage "UserBadge created"
                    redirectTo UserBadgesAction

    action DeleteUserBadgeAction { userBadgeId } = do
        userBadge <- fetch userBadgeId
        deleteRecord userBadge
        setSuccessMessage "UserBadge deleted"
        redirectTo UserBadgesAction

buildUserBadge userBadge = userBadge
    |> fill @["userId","badge"]
