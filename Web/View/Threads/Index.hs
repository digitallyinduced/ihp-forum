module Web.View.Threads.Index (IndexView(..), renderThread) where
import Web.View.Prelude

data IndexView = IndexView
    { threads :: [Thread]
    , threadUsers :: [User]
    , threadTopics :: [Topic]
    }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <div class="threads">{forEach threads (renderThread threadUsers threadTopics)}</div>
    |]

renderThread :: [User] -> [Topic] -> Thread -> Html
renderThread users topics thread = [hsx|
    <div class="thread">
        <a class="thread-title" href={ShowThreadAction thread.id}>
            {thread.title}

        </a>

        <a class="thread-body" href={ShowThreadAction thread.id}>
            {renderMarkdown thread.body}
        </a>
        <div class="text-muted">
            {renderUser thread.userId}
            , {timeAgo thread.createdAt}

            {renderTopic thread.topicId}
        </div>
    </div>
|]
  where
    renderUser userId = case find (\u -> u.id == userId) users of
        Just user -> [hsx|<a class="text-muted" href={ShowUserAction user.id}>{user.name}</a>|]
        Nothing -> [hsx||]
    renderTopic topicId = case find (\t -> t.id == topicId) topics of
        Just topic -> [hsx|<span class="ml-1">in <a href={ShowTopicAction topic.id} class="text-muted">{topic.name}</a></span>|]
        Nothing -> [hsx||]
