module Web.View.Topics.New where
import Web.View.Prelude

data NewView = NewView { topic :: Topic }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={TopicsAction}>Topics</a></li>
                <li class="breadcrumb-item active">New Topic</li>
            </ol>
        </nav>
        <h1>New Topic</h1>
        {renderForm topic}
    |]

renderForm :: Topic -> Html
renderForm topic = formFor topic [hsx|
    {textField #name}
    {submitButton}
|]
