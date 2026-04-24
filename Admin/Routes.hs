module Admin.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture, parseCapture)
import Generated.Types
import Admin.Types

-- URLs match the legacy AutoRoute shape exactly — the /admin/ prefix
-- comes from AutoRoute's module-based prefixing, so we spell it out.
[routes|adminRoutes
-- Admins
GET    /admin/Admins              AdminsAction
GET    /admin/NewAdmin            NewAdminAction
POST   /admin/CreateAdmin         CreateAdminAction
GET    /admin/ShowAdmin           ShowAdminAction
GET    /admin/EditAdmin           EditAdminAction
POST   /admin/UpdateAdmin         UpdateAdminAction
DELETE /admin/DeleteAdmin         DeleteAdminAction

-- User badges
GET    /admin/UserBadges          UserBadgesAction
GET    /admin/NewUserBadge        NewUserBadgeAction
POST   /admin/CreateUserBadge     CreateUserBadgeAction
GET    /admin/ShowUserBadge       ShowUserBadgeAction
GET    /admin/EditUserBadge       EditUserBadgeAction
POST   /admin/UpdateUserBadge     UpdateUserBadgeAction
DELETE /admin/DeleteUserBadge     DeleteUserBadgeAction

-- Admin login
GET    /admin/NewSession          NewSessionAction
POST   /admin/CreateSession       CreateSessionAction
DELETE /admin/DeleteSession       DeleteSessionAction
|]
