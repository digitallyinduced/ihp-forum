module Main where
import IHP.Prelude

import Config
import qualified IHP.Server
import IHP.RouterSupport
import IHP.FrameworkConfig
import Web.FrontController
import Web.Types
import Admin.FrontController
import Admin.Types

instance FrontController RootApplication where
    controllers = [
            mountFrontController WebApplication
            , mountFrontController AdminApplication
        ]

main :: IO ()
main = IHP.Server.run
