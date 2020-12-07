module Admin.View.UserBadges.New where
import Admin.View.Prelude

data NewView = NewView { userBadge :: UserBadge }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={UserBadgesAction}>UserBadges</a></li>
                <li class="breadcrumb-item active">New UserBadge</li>
            </ol>
        </nav>
        <h1>New UserBadge</h1>
        {renderForm userBadge}
    |]

renderForm :: UserBadge -> Html
renderForm userBadge = formFor userBadge [hsx|
    {textField #userId}
    {selectField #badge badges}
    {submitButton}
|]
    where
        badges :: [Badge]
        badges = [IhpContributor, IhpStickerOwner, DiTeam, DiPartner, ForumSamaritan]

instance CanSelect Badge where
    type SelectValue Badge = Badge
    selectValue value = value
    selectLabel = tshow
