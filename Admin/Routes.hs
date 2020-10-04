module Admin.Routes where
import IHP.RouterPrelude
import Generated.Types
import Admin.Types

-- Generator Marker
instance AutoRoute SessionsController
instance AutoRoute UserBadgesController
type instance ModelControllerMap AdminApplication UserBadge = UserBadgesController
instance AutoRoute AdminsController
type instance ModelControllerMap AdminApplication Admin = AdminsController

