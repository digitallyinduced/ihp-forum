module Web.Types where
import IHP.Prelude
import qualified IHP.Controller.Session
import qualified IHP.ControllerSupport as ControllerSupport
import IHP.ModelSupport
import Application.Helper.Controller
import IHP.ViewSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)

data ViewContext = ViewContext
    { requestContext :: ControllerSupport.RequestContext
    , flashMessages :: [IHP.Controller.Session.FlashMessage]
    , controllerContext :: ControllerSupport.ControllerContext
    , layout :: Layout
    , user :: Maybe User
    }

data ThreadsController
    = ThreadsAction
    | NewThreadAction
    | ShowThreadAction { threadId :: !(Id Thread) }
    | CreateThreadAction
    | EditThreadAction { threadId :: !(Id Thread) }
    | UpdateThreadAction { threadId :: !(Id Thread) }
    | DeleteThreadAction { threadId :: !(Id Thread) }
    deriving (Eq, Show, Data)

data UsersController
    = NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data CommentsController
    = NewCommentAction { threadId :: !(Id Thread) }
    | ShowCommentAction { commentId :: !(Id Comment) }
    | CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data TopicsController
    = TopicsAction
    | NewTopicAction
    | ShowTopicAction { topicId :: !(Id Topic) }
    | CreateTopicAction
    | EditTopicAction { topicId :: !(Id Topic) }
    | UpdateTopicAction { topicId :: !(Id Topic) }
    | DeleteTopicAction { topicId :: !(Id Topic) }
    deriving (Eq, Show, Data)
