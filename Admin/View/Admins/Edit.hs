module Admin.View.Admins.Edit where
import Admin.View.Prelude

data EditView = EditView { admin :: Admin }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={AdminsAction}>Admins</a></li>
                <li class="breadcrumb-item active">Edit Admin</li>
            </ol>
        </nav>
        <h1>Edit Admin</h1>
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
