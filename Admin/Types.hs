module Admin.Types where
import IHP.Prelude
import qualified IHP.Controller.Session
import qualified IHP.ControllerSupport as ControllerSupport
import IHP.ModelSupport
import Application.Helper.Controller
import IHP.ViewSupport
import Generated.Types

import IHP.LoginSupport.Types

data AdminApplication = AdminApplication deriving (Eq, Show)

data UserBadgesController
    = UserBadgesAction
    | NewUserBadgeAction
    | ShowUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | CreateUserBadgeAction
    | EditUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | UpdateUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | DeleteUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    deriving (Eq, Show, Data)

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
     deriving (Eq, Show, Data)

instance HasNewSessionUrl Admin where
    newSessionUrl admin = "/admin/NewSession"

data AdminsController
    = AdminsAction
    | NewAdminAction
    | ShowAdminAction { adminId :: !(Id Admin) }
    | CreateAdminAction
    | EditAdminAction { adminId :: !(Id Admin) }
    | UpdateAdminAction { adminId :: !(Id Admin) }
    | DeleteAdminAction { adminId :: !(Id Admin) }
    deriving (Eq, Show, Data)
