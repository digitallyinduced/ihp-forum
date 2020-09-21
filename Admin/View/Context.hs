module Admin.View.Context where

import IHP.Prelude
import qualified IHP.Controller.Session
import IHP.ControllerSupport  (RequestContext (RequestContext))
import qualified IHP.ControllerSupport
import IHP.ModelSupport
import Application.Helper.Controller
import Generated.Types
import qualified IHP.ViewSupport as ViewSupport
import Admin.View.Layout
import Admin.Types

instance ViewSupport.CreateViewContext ViewContext where
    type ViewApp ViewContext = AdminApplication
    createViewContext = do
        flashMessages <- IHP.Controller.Session.getAndClearFlashMessages
        let viewContext = ViewContext {
                requestContext = ?requestContext,
                -- user = currentUserOrNothing,
                flashMessages,
                controllerContext = ?controllerContext,
                layout = let ?viewContext = viewContext in defaultLayout
            }
        pure viewContext
