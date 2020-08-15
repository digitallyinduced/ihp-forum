module Web.View.Threads.New where
import Web.View.Prelude

data NewView = NewView { thread :: Thread, topics :: [Topic] }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <h1>New Thread</h1>
        {renderForm thread}
    |]
        where
            renderForm :: Thread -> Html
            renderForm thread = formFor thread [hsx|
                {textField #title}
                {(textareaField #body) { helpText = "You can use markdown here."} }
                {(selectField #topicId topics) { helpText = "Please pick the topic that best matches your question"}}
                {submitButton}
            |]

instance CanSelect Topic where
    type SelectValue Topic = Id Topic
    selectValue = get #id
    selectLabel topic = get #name topic <> ": " <> get #description topic