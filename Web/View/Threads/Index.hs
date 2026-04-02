module Web.View.Threads.Index where
import Web.View.Prelude

data IndexView = IndexView
    { threads :: [Thread]
    , threadUsers :: [User]
    , threadTopics :: [Topic]
    }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <div class="threads">{forEach threads renderThread}</div>
    |]
      where
        lookupUser userId = find (\u -> u.id == userId) threadUsers
        lookupTopic topicId = find (\t -> t.id == topicId) threadTopics

        renderThread :: Thread -> Html
        renderThread thread = [hsx|
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
            renderUser userId = case lookupUser userId of
                Just user -> [hsx|<a class="text-muted" href={ShowUserAction user.id}>{user.name}</a>|]
                Nothing -> [hsx||]
            renderTopic topicId = case lookupTopic topicId of
                Just topic -> [hsx|<span class="ml-1">in <a href={ShowTopicAction topic.id} class="text-muted">{topic.name}</a></span>|]
                Nothing -> [hsx||]
