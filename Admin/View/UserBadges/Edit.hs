module Admin.View.UserBadges.Edit where
import Admin.View.Prelude

data EditView = EditView { userBadge :: UserBadge }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={UserBadgesAction}>UserBadges</a></li>
                <li class="breadcrumb-item active">Edit UserBadge</li>
            </ol>
        </nav>
        <h1>Edit UserBadge</h1>
        {renderForm userBadge}
    |]

renderForm :: UserBadge -> Html
renderForm userBadge = formFor userBadge [hsx|
    {textField #userId}
    {textField #badge}
    {submitButton}
|]
