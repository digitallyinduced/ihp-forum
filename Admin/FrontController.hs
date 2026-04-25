module Admin.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Admin.Types
import Admin.Routes (adminRoutes)
import Admin.Controller.UserBadges
import Admin.Controller.Prelude
import Admin.View.Layout

-- Controller Imports
import Admin.Controller.Admins
import IHP.LoginSupport.Middleware
import Admin.Controller.Sessions

-- Routes defined via the [routes|adminRoutes …|] DSL in Admin.Routes.
instance FrontController AdminApplication where
    controllers = adminRoutes

instance InitControllerContext AdminApplication where
    initContext = do
        setLayout defaultLayout
        initAuthentication @Admin
