module Web.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture)
import Generated.Types
import Web.Types

[routes|webRoutes
-- Homepage
GET    /                                              ThreadsAction

-- Threads
GET    /threads                                       ThreadsAction
GET    /threads/new                                   NewThreadAction
POST   /threads                                       CreateThreadAction
GET    /threads/{threadId}                            ShowThreadAction
GET    /threads/{threadId}/edit                       EditThreadAction
PATCH  /threads/{threadId}                            UpdateThreadAction
DELETE /threads/{threadId}                            DeleteThreadAction

-- Topics
GET    /topics                                        TopicsAction
GET    /topics/new                                    NewTopicAction
POST   /topics                                        CreateTopicAction
GET    /topics/{topicId}                              ShowTopicAction
GET    /topics/{topicId}/edit                         EditTopicAction
PATCH  /topics/{topicId}                              UpdateTopicAction
DELETE /topics/{topicId}                              DeleteTopicAction

-- Comments (nested under threads for NewComment)
GET    /threads/{threadId}/comments/new               NewCommentAction
POST   /comments                                      CreateCommentAction
GET    /comments/{commentId}                          ShowCommentAction
GET    /comments/{commentId}/edit                     EditCommentAction
PATCH  /comments/{commentId}                          UpdateCommentAction
DELETE /comments/{commentId}                          DeleteCommentAction

-- Users
GET    /users/new                                     NewUserAction
POST   /users                                         CreateUserAction
GET    /users/{userId}                                ShowUserAction
GET    /users/{userId}/edit                           EditUserAction
PATCH  /users/{userId}                                UpdateUserAction
DELETE /users/{userId}                                DeleteUserAction

-- Sessions (login)
GET    /sessions/new                                  NewSessionAction
POST   /sessions                                      CreateSessionAction
DELETE /sessions                                      DeleteSessionAction
|]
