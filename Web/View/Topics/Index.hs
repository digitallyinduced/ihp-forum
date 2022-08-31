module Web.View.Topics.Index where
import Web.View.Prelude

data IndexView = IndexView { topics :: [Topic] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {forEach topics renderTopic}
    |]


renderTopic :: Topic -> Html
renderTopic topic = [hsx|
    <div class="topic">
        <a class="topic-title" href={ShowTopicAction topic.id}>
            {topic.name}
        </a>

        <div class="topic-description">
            {topic.description}
        </div>

        <div class="topic-meta">
            Last activity: {timeAgo topic.lastActivityAt}
            , {tshow (topic.threadsCount) <> " Threads"}
        </div>
    </div>
|]
