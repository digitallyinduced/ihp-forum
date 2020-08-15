module Web.View.Comments.New where
import Web.View.Prelude

data NewView = NewView { comment :: Comment, thread :: Thread }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <a href={ShowThreadAction (get #id thread)}>Go back to Thread</a>
        <h1>{get #title thread}</h1>
        {renderForm comment}
    |]

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {hiddenField #threadId}
    {(textareaField #body) { fieldLabel = "Your Comment:", helpText = "You can use markdown here." } }
    {submitButton}
|]
