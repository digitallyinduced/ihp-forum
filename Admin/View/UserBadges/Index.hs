module Admin.View.UserBadges.Index where
import Admin.View.Prelude

data IndexView = IndexView { userBadges :: [Include "userId" UserBadge] }

instance View IndexView ViewContext where
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

renderUserBadge userBadge = [hsx|
    <tr>
        <td> {(get #userId userBadge |> get #name)} </td>
        <td><span class="badge badge-pill badge-primary"> {(fromMaybe "" (lookup (get #badge userBadge) badgeMap))} </span></td>
        <td><a href={ShowUserBadgeAction (get #id userBadge)}>Show</a></td>
        <td><a href={EditUserBadgeAction (get #id userBadge)} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserBadgeAction (get #id userBadge)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
      where 
        badgeMap = [(IhpContributor, "IHP Contributor"::Text) 
                    ,(IhpStickerOwner, "IHP Sticker Owner"::Text) 
                    ,(DiTeam, "di Team"::Text)
                    ,(DiPartner, "di Partner"::Text)
                    ,(ForumSamaritan, "Forum Samaritan"::Text)
                    ]  
