module Admin.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture)
import Generated.Types
import Admin.Types

[routes|adminRoutes
-- Admins
GET    /admin/admins                                  AdminsAction
GET    /admin/admins/new                              NewAdminAction
POST   /admin/admins                                  CreateAdminAction
GET    /admin/admins/{adminId}                        ShowAdminAction
GET    /admin/admins/{adminId}/edit                   EditAdminAction
PATCH  /admin/admins/{adminId}                        UpdateAdminAction
DELETE /admin/admins/{adminId}                        DeleteAdminAction

-- User badges
GET    /admin/user-badges                             UserBadgesAction
GET    /admin/user-badges/new                         NewUserBadgeAction
POST   /admin/user-badges                             CreateUserBadgeAction
GET    /admin/user-badges/{userBadgeId}               ShowUserBadgeAction
GET    /admin/user-badges/{userBadgeId}/edit          EditUserBadgeAction
PATCH  /admin/user-badges/{userBadgeId}               UpdateUserBadgeAction
DELETE /admin/user-badges/{userBadgeId}               DeleteUserBadgeAction

-- Admin login
GET    /admin/sessions/new                            NewSessionAction
POST   /admin/sessions                                CreateSessionAction
DELETE /admin/sessions                                DeleteSessionAction
|]
