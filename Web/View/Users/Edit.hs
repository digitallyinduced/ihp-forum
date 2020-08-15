module Web.View.Users.Edit where
import Web.View.Prelude

data EditView = EditView { user :: User }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <h1>Update Your Profile Information</h1>
        {renderForm user}
    |]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {textField #name}
    {textField #email}
    {textField #githubName}
    {submitButton}
|]
