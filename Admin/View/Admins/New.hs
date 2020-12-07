module Admin.View.Admins.New where
import Admin.View.Prelude

data NewView = NewView { admin :: Admin }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={AdminsAction}>Admins</a></li>
                <li class="breadcrumb-item active">New Admin</li>
            </ol>
        </nav>
        <h1>New Admin</h1>
        {renderForm admin}
    |]

renderForm :: Admin -> Html
renderForm admin = formFor admin [hsx|
    {textField #name}
    {textField #email}
    {textField #passwordHash}
    {textField #failedLoginAttempts}
    {submitButton}
|]
