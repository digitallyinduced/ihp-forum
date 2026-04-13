module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import IHP.LoginSupport.Middleware (authMiddleware, adminAuthMiddleware)
import Generated.Types

config :: ConfigBuilder
config = do
    -- See https://ihp.digitallyinduced.com/Guide/config.html
    -- for what you can do here
    option $ AuthMiddleware (authMiddleware @User . adminAuthMiddleware @Admin)

slackWebHook :: Maybe String
slackWebHook = Nothing
