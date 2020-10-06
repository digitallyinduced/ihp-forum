module Admin.Controller.Sessions where

import Admin.Controller.Prelude
import Admin.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller SessionsController where
    action NewSessionAction = Sessions.newSessionAction @Admin
    action CreateSessionAction = Sessions.createSessionAction @Admin
    action DeleteSessionAction = Sessions.deleteSessionAction @Admin

instance Sessions.SessionsControllerConfig Admin where
    afterLoginRedirectPath = "/admin/UserBadges"

