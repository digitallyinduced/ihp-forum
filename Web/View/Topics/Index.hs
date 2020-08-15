module Web.View.Topics.Index where
import Web.View.Prelude

data IndexView = IndexView { topics :: [Topic] }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        {forEach topics renderTopic}
    |]


renderTopic :: Topic -> Html
renderTopic topic = [hsx|
    <div class="topic">
        <a class="topic-title" href={ShowTopicAction (get #id topic)}>
            {get #name topic}
        </a>

        <div class="topic-description">
            {get #description topic}
        </div>

        <div class="topic-meta">
            Last activity: {get #lastActivityAt topic |> timeAgo}
            , {tshow (get #threadsCount topic) <> " Threads"}
        </div>
    </div>
|]
