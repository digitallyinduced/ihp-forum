module Admin.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Admin.Types
import Admin.Controller.UserBadges
import Admin.Controller.Prelude
import Admin.View.Layout

-- Controller Imports
import Admin.Controller.Admins
import IHP.Welcome.Controller
import IHP.LoginSupport.Middleware
import Admin.Controller.Sessions

instance FrontController AdminApplication where
    controllers =
        [ parseRoute @UserBadgesController
        , parseRoute @SessionsController
        -- Generator Marker
        , parseRoute @AdminsController
        ]

instance InitControllerContext AdminApplication where
    initContext = do
        setLayout defaultLayout
        initAuthentication @Admin
