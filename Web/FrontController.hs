module Web.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Web.Types
import Web.Controller.Prelude
import Web.View.Layout

-- Controller Imports
import Web.Controller.Topics
import Web.Controller.Comments
import Web.Controller.Users
import Web.Controller.Threads
import IHP.Welcome.Controller
import IHP.LoginSupport.Middleware
import Web.Controller.Sessions

instance FrontController WebApplication where
    controllers =
        [ startPage ThreadsAction
        -- Generator Marker
        , parseRoute @TopicsController
        , parseRoute @CommentsController
        , parseRoute @UsersController
        , parseRoute @ThreadsController
        , parseRoute @SessionsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAuthentication @User
