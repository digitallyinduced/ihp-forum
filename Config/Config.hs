module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import qualified IHP.LoginSupport.Middleware as Auth
import Generated.Types

config :: ConfigBuilder
config = do
    -- See https://ihp.digitallyinduced.com/Guide/config.html
    -- for what you can do here
    option $ AuthMiddleware (Auth.authMiddleware @User . Auth.adminAuthMiddleware @Admin)

slackWebHook :: Maybe String
slackWebHook = Nothing
