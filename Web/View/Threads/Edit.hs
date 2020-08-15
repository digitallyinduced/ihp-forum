module Web.View.Threads.Edit where
import Web.View.Prelude

data EditView = EditView { thread :: Thread }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ThreadsAction}>Threads</a></li>
                <li class="breadcrumb-item active">Edit Thread</li>
            </ol>
        </nav>
        <h1>Edit Thread</h1>
        {renderForm thread}
    |]

renderForm :: Thread -> Html
renderForm thread = formFor thread [hsx|
    {textField #title}
    {textField #body}
    {submitButton}
|]
