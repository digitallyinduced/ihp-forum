module Admin.Controller.Admins where

import Admin.Controller.Prelude

import Admin.View.Admins.Index
import Admin.View.Admins.New
import Admin.View.Admins.Edit
import Admin.View.Admins.Show

instance Controller AdminsController where
    beforeAction = ensureIsAdmin @Admin

    action AdminsAction = do
        admins <- query @Admin |> fetch
        render IndexView { .. }

    action NewAdminAction = do
        let admin = newRecord
        render NewView { .. }

    action ShowAdminAction { adminId } = do
        admin <- fetch adminId
        render ShowView { .. }

    action EditAdminAction { adminId } = do
        admin <- fetch adminId
        render EditView { .. }

    action UpdateAdminAction { adminId } = do
        admin <- fetch adminId
        admin
            |> buildAdmin
            |> ifValid \case
                Left admin -> render EditView { .. }
                Right admin -> do
                    admin <- admin |> updateRecord
                    setSuccessMessage "Admin updated"
                    redirectTo EditAdminAction { .. }

    action CreateAdminAction = do
        let admin = newRecord @Admin
        admin
            |> buildAdmin
            |> ifValid \case
                Left admin -> render NewView { .. } 
                Right admin -> do
                    admin <- admin |> createRecord
                    setSuccessMessage "Admin created"
                    redirectTo AdminsAction

    action DeleteAdminAction { adminId } = do
        admin <- fetch adminId
        deleteRecord admin
        setSuccessMessage "Admin deleted"
        redirectTo AdminsAction

buildAdmin admin = admin
    |> fill @["name","email","passwordHash","failedLoginAttempts"]
