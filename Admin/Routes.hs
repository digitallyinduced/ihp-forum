module Admin.Routes where
import IHP.RouterPrelude
import IHP.Router.DSL (routes)
import IHP.Router.Capture (renderCapture, parseCapture)
import Generated.Types
import Admin.Types

-- URLs match the legacy AutoRoute shape exactly — the /admin/ prefix
-- comes from AutoRoute's module-based prefixing, so we spell it out.
-- Each ?key suffix declares the query param that carries the record
-- field's value, preserving AutoRoute's /admin/ShowAdmin?adminId=<uuid>
-- URL shape.
[routes|adminRoutes
-- Admins
GET    /admin/Admins                     AdminsAction
GET    /admin/NewAdmin                   NewAdminAction
POST   /admin/CreateAdmin                CreateAdminAction
GET    /admin/ShowAdmin?adminId          ShowAdminAction
GET    /admin/EditAdmin?adminId          EditAdminAction
POST   /admin/UpdateAdmin?adminId        UpdateAdminAction
DELETE /admin/DeleteAdmin?adminId        DeleteAdminAction

-- User badges
GET    /admin/UserBadges                 UserBadgesAction
GET    /admin/NewUserBadge               NewUserBadgeAction
POST   /admin/CreateUserBadge            CreateUserBadgeAction
GET    /admin/ShowUserBadge?userBadgeId  ShowUserBadgeAction
GET    /admin/EditUserBadge?userBadgeId  EditUserBadgeAction
POST   /admin/UpdateUserBadge?userBadgeId UpdateUserBadgeAction
DELETE /admin/DeleteUserBadge?userBadgeId DeleteUserBadgeAction

-- Admin login
GET    /admin/NewSession                 NewSessionAction
POST   /admin/CreateSession              CreateSessionAction
DELETE /admin/DeleteSession              DeleteSessionAction
|]
