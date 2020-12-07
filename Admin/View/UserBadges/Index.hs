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
        <td> {(get #userId userbadge |> get #name)} </td>
        <td><span class={snd badgeTuple}> {fst badgeTuple} </span></td>
        <td><a href={ShowUserBadgeAction (get #id userbadge)}>Show</a></td>
        <td><a href={EditUserBadgeAction (get #id userbadge)} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserBadgeAction (get #id userbadge)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
    where
        badgeTuple = fromMaybe ("", "") (lookup (get #badge userbadge) badgeMap)
