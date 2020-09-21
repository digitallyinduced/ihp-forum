module Admin.Types where
import IHP.Prelude
import qualified IHP.Controller.Session
import qualified IHP.ControllerSupport as ControllerSupport
import IHP.ModelSupport
import Application.Helper.Controller
import IHP.ViewSupport
import Generated.Types

data AdminApplication = AdminApplication deriving (Eq, Show)

data ViewContext = ViewContext
    { requestContext :: ControllerSupport.RequestContext
    , flashMessages :: [IHP.Controller.Session.FlashMessage]
    , controllerContext :: ControllerSupport.ControllerContext
    , layout :: Layout
    }

data UserBadgesController
    = UserBadgesAction
    | NewUserBadgeAction
    | ShowUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | CreateUserBadgeAction
    | EditUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | UpdateUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    | DeleteUserBadgeAction { userBadgeId :: !(Id UserBadge) }
    deriving (Eq, Show, Data)
