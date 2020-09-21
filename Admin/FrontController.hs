module Admin.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Admin.Types
import Admin.Controller.UserBadges

-- Controller Imports
import IHP.Welcome.Controller

instance FrontController AdminApplication where
    controllers = 
        [ startPage WelcomeAction
        , parseRoute @UserBadgesController
        -- Generator Marker
        ]

instance InitControllerContext AdminApplication

