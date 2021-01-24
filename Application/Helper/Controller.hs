module Application.Helper.Controller
( module IHP.LoginSupport.Helper.Controller
, sendToSlackAsync
) where

-- Here you can add functions which are available in all your controllers
import IHP.LoginSupport.Helper.Controller
import IHP.Prelude
import Generated.Types

import qualified Network.Wreq as Wreq
import qualified Config
import qualified Control.Concurrent.Async as Async
import Data.Aeson

type instance CurrentUserRecord = User
type instance CurrentAdminRecord = Admin

sendToSlack :: Text -> IO ()
sendToSlack message = case Config.slackWebHook of
        Just slackWebHook -> do
            let payload :: Value = (toJSON (object ["text" .= message]))
            response <- Wreq.post slackWebHook payload
            pure ()
        Nothing -> do
            putStrLn "Slack hook not configured"

sendToSlackAsync :: Text -> IO (Async.Async ())
sendToSlackAsync message = Async.async (sendToSlack message)