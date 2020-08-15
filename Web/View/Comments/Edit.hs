module Web.View.Comments.Edit where
import Web.View.Prelude

data EditView = EditView
    { comment :: Comment
    , thread :: Thread
    }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <a href={ShowThreadAction (get #id thread)}>
            Go back to <q>{get #title thread}</q>
        </a>
        <h1>Edit Comment</h1>
        {renderForm comment}
    |]

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {hiddenField #threadId}
    {hiddenField #userId}
    {textareaField #body}
    {submitButton}
|]
