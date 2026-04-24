module Web.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture, parseCapture)
import Generated.Types
import Web.Types

-- URLs match the legacy AutoRoute shapes exactly: the Show/Update/Delete
-- actions render as /ShowThread?threadId=<uuid> etc. The explicit
-- ?threadId clauses preserve existing deep links, search indexes, and
-- third-party callers.
[routes|webRoutes
-- Threads
GET    /Threads                     ThreadsAction
GET    /NewThread                   NewThreadAction
POST   /CreateThread                CreateThreadAction
GET    /ShowThread?threadId         ShowThreadAction
GET    /EditThread?threadId         EditThreadAction
POST   /UpdateThread?threadId       UpdateThreadAction
DELETE /DeleteThread?threadId       DeleteThreadAction

-- Topics
GET    /Topics                      TopicsAction
GET    /NewTopic                    NewTopicAction
POST   /CreateTopic                 CreateTopicAction
GET    /ShowTopic?topicId           ShowTopicAction
GET    /EditTopic?topicId           EditTopicAction
POST   /UpdateTopic?topicId         UpdateTopicAction
DELETE /DeleteTopic?topicId         DeleteTopicAction

-- Comments
GET    /NewComment?threadId         NewCommentAction
POST   /CreateComment               CreateCommentAction
GET    /ShowComment?commentId       ShowCommentAction
GET    /EditComment?commentId       EditCommentAction
POST   /UpdateComment?commentId     UpdateCommentAction
DELETE /DeleteComment?commentId     DeleteCommentAction

-- Users
GET    /NewUser                     NewUserAction
POST   /CreateUser                  CreateUserAction
GET    /ShowUser?userId             ShowUserAction
GET    /EditUser?userId             EditUserAction
POST   /UpdateUser?userId           UpdateUserAction
DELETE /DeleteUser?userId           DeleteUserAction

-- Sessions
GET    /NewSession                  NewSessionAction
POST   /CreateSession               CreateSessionAction
DELETE /DeleteSession                DeleteSessionAction
|]
