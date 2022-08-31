module Web.View.Threads.Edit where
import Web.View.Prelude

data EditView = EditView { thread :: Thread, topics :: [Topic] }

instance View EditView where
    html EditView { .. } = [hsx|
        <h1>Edit Thread</h1>
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
    selectLabel topic = topic.name <> ": " <> topic.description
