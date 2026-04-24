module Web.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Web.Types
import Web.Routes (webRoutes)
import Web.Controller.Prelude
import Web.View.Layout

-- Controller Imports
import Web.Controller.Topics
import Web.Controller.Comments
import Web.Controller.Users
import Web.Controller.Threads
import IHP.LoginSupport.Middleware
import Web.Controller.Sessions

-- Routes defined via the [routes|webRoutes …|] DSL in Web.Routes.
-- The splice emits HasPath + CanRoute instances for each action's
-- controller, plus the `webRoutes` binding below. The home page
-- (startPage) stays an explicit entry because the DSL doesn't carry
-- the AutoRoute `startPage` semantics.
instance FrontController WebApplication where
    controllers = startPage ThreadsAction : webRoutes

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAuthentication @User
