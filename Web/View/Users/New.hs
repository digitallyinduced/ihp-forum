module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
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
    {(textField #name) { placeholder = "Your username; it's recommended to use your GitHub username"}}
    {(textField #email) { placeholder = "Not shown anywhere in the forum"}}
    {(passwordField #passwordHash) { fieldLabel = "Password:"}}
    {(textField #githubName) { fieldLabel = "GitHub username", placeholder = "Optional, so we can link to your GitHub"}}
    {submitButton}
|]
