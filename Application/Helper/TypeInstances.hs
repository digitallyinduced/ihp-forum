-- | Orphan instances for 'IHP.LoginSupport.Types.CurrentUserRecord' and
-- 'IHP.LoginSupport.Types.CurrentAdminRecord'.
--
-- Keeping these in their own tiny module avoids import cycles when
-- `Config/Config.hs` (which can't import `Application.Helper.Controller`)
-- needs the instances in scope for 'authMiddleware @User'.
module Application.Helper.TypeInstances () where

import Generated.Types
import IHP.LoginSupport.Types

type instance CurrentUserRecord = User
type instance CurrentAdminRecord = Admin
