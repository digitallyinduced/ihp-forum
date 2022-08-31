module Admin.View.UserBadges.Index where
import Admin.View.Prelude
import Application.Helper.View

data IndexView = IndexView { userBadges :: [Include "userId" UserBadge] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={UserBadgesAction}>UserBadges</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewUserBadgeAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>UserBadge</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach userBadges renderUserBadge}</tbody>
            </table>
        </div>
    |]

renderUserBadge userbadge = [hsx|
    <tr>
        <td> {userbadge.userId.name} </td>
        <td><span class={snd badgeTuple}> {fst badgeTuple} </span></td>
        <td><a href={ShowUserBadgeAction userbadge.id}>Show</a></td>
        <td><a href={EditUserBadgeAction userbadge.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserBadgeAction userbadge.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
    where
        badgeTuple = fromMaybe ("", "") (lookup userbadge.badge badgeMap)
