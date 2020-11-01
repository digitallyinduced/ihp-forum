module Admin.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Admin.Types
import Admin.Controller.UserBadges

-- Controller Imports
import Admin.Controller.Admins
import IHP.Welcome.Controller
import IHP.LoginSupport.Middleware
import Admin.Controller.Sessions

instance FrontController AdminApplication where
    controllers = 
        [
        , parseRoute @UserBadgesController
        , parseRoute @SessionsController
        -- Generator Marker
        , parseRoute @AdminsController
        ]

instance InitControllerContext AdminApplication where
    initContext = initAuthentication @Admin

