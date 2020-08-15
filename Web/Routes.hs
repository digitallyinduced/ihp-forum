module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute ThreadsController
type instance ModelControllerMap WebApplication Thread = ThreadsController

instance AutoRoute UsersController
type instance ModelControllerMap WebApplication User = UsersController

instance AutoRoute CommentsController
type instance ModelControllerMap WebApplication Comment = CommentsController

instance AutoRoute SessionsController


instance AutoRoute TopicsController
type instance ModelControllerMap WebApplication Topic = TopicsController

