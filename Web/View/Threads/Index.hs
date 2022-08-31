module Web.View.Threads.Index where
import Web.View.Prelude

data IndexView = IndexView { threads :: [Include' ["userId", "topicId"] Thread] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <div class="threads">{forEach threads renderThread}</div>
    |]


renderThread thread = [hsx|
    <div class="thread">
        <a class="thread-title" href={ShowThreadAction thread.id}>
            {thread.title}

        </a>

        <a class="thread-body" href={ShowThreadAction thread.id}>
            {renderMarkdown thread.body}
        </a>
        <div class="text-muted">
            <a class="text-muted" href={ShowUserAction user.id}>{user.name}</a>
            , {timeAgo thread.createdAt}

            <span class="ml-1">in <a href={ShowTopicAction topic.id} class="text-muted">{topic.name}</a></span>
        </div>
    </div>
|]
    where
        user = thread.userId
        topic = thread.topicId
