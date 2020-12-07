module Web.View.Topics.Edit where
import Web.View.Prelude

data EditView = EditView { topic :: Topic }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={TopicsAction}>Topics</a></li>
                <li class="breadcrumb-item active">Edit Topic</li>
            </ol>
        </nav>
        <h1>Edit Topic</h1>
        {renderForm topic}
    |]

renderForm :: Topic -> Html
renderForm topic = formFor topic [hsx|
    {textField #name}
    {textareaField #description}
    {submitButton}
|]
