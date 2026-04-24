module Web.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture, parseCapture)
import Generated.Types
import Web.Types

-- URLs match the legacy AutoRoute shapes exactly: the Show/Update/Delete
-- actions render as /ShowThread?threadId=<uuid> etc. via query-string
-- capture. Existing deep links, search indexes, and third-party callers
-- keep working.
[routes|webRoutes
-- Threads
GET    /Threads                   ThreadsAction
GET    /NewThread                 NewThreadAction
POST   /CreateThread              CreateThreadAction
GET    /ShowThread                ShowThreadAction
GET    /EditThread                EditThreadAction
POST   /UpdateThread              UpdateThreadAction
DELETE /DeleteThread              DeleteThreadAction

-- Topics
GET    /Topics                    TopicsAction
GET    /NewTopic                  NewTopicAction
POST   /CreateTopic               CreateTopicAction
GET    /ShowTopic                 ShowTopicAction
GET    /EditTopic                 EditTopicAction
POST   /UpdateTopic               UpdateTopicAction
DELETE /DeleteTopic               DeleteTopicAction

-- Comments
GET    /NewComment                NewCommentAction
POST   /CreateComment             CreateCommentAction
GET    /ShowComment               ShowCommentAction
GET    /EditComment               EditCommentAction
POST   /UpdateComment             UpdateCommentAction
DELETE /DeleteComment             DeleteCommentAction

-- Users
GET    /NewUser                   NewUserAction
POST   /CreateUser                CreateUserAction
GET    /ShowUser                  ShowUserAction
GET    /EditUser                  EditUserAction
POST   /UpdateUser                UpdateUserAction
DELETE /DeleteUser                DeleteUserAction

-- Sessions
GET    /NewSession                NewSessionAction
POST   /CreateSession             CreateSessionAction
DELETE /DeleteSession             DeleteSessionAction
|]
