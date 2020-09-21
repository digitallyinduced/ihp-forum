module Admin.Routes where
import IHP.RouterPrelude
import Generated.Types
import Admin.Types

-- Generator Marker
instance AutoRoute UserBadgesController
type instance ModelControllerMap AdminApplication UserBadge = UserBadgesController
