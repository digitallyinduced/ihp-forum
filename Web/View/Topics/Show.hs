module Web.View.Topics.Show where
import Web.View.Prelude

data ShowView = ShowView
    { topic :: Topic
    , threads :: [Thread]
    , threadUsers :: [User]
    , threadTopics :: [Topic]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>{topic.name}</h1>

        <div class="threads">
            {forEach threads renderThread}
        </div>
        {whenEmpty threads emptyTopic}
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
                Just t -> [hsx|<span class="ml-1">in <a href={ShowTopicAction t.id} class="text-muted">{t.name}</a></span>|]
                Nothing -> [hsx||]

emptyTopic = [hsx|
    <div class="text-muted text-center p-5 h3">
        No threads in this topic yet, be the first one to change this! :)
        <a href={NewThreadAction} class="btn btn-primary mt-4">+ New Thread</a>
    </div>
|]
