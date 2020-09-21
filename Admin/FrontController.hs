module Admin.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Admin.Types

-- Controller Imports
import IHP.Welcome.Controller

instance FrontController AdminApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        ]

instance InitControllerContext AdminApplication
