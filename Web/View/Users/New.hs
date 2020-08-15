module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <div id={currentViewId}>
            <h1>Register</h1>
            <p>
                Here you can create a new account for the IHP Forum.
            </p>
            {renderForm user}
        </div>
    |]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #name) { placeholder = "Your username, it's recommded to use your GitHub user name"}}
    {(textField #email) { placeholder = "Not shown anywhere in the forum"}}
    {(passwordField #passwordHash) { fieldLabel = "Password:"}}
    {(textField #githubName) { fieldLabel = "GitHub Username", placeholder = "optional, so we can link to your GitHub"}}
    {submitButton}
|]
