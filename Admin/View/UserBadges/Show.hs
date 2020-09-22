module Admin.View.UserBadges.Show where
import Admin.View.Prelude

data ShowView = ShowView { userBadge :: UserBadge }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={UserBadgesAction}> UserBadges </a></li>
                <li class="breadcrumb-item active">Show UserBadge</li>
            </ol>
        </nav>
        <h1>Show UserBadge</h1>
    |]
