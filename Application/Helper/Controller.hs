module Application.Helper.Controller (
    module IHP.LoginSupport.Helper.Controller
) where

-- Here you can add functions which are available in all your controllers
import IHP.LoginSupport.Helper.Controller
import Generated.Types

type instance CurrentUserRecord = User
type instance CurrentAdminRecord = Admin

