module Web.View.Threads.Index where
import Web.View.Prelude

data IndexView = IndexView { threads :: [Include' ["userId", "topicId"] Thread] }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        <div class="threads">{forEach threads renderThread}</div>
    |]


renderThread thread = [hsx|
    <div class="thread">
        <a class="thread-title" href={ShowThreadAction (get #id thread)}>
            {get #title thread}

        </a>

        <a class="thread-body" href={ShowThreadAction (get #id thread)}>
            {get #body thread |> renderMarkdown}
        </a>
        <div class="text-muted">
            <a class="text-muted" href={ShowUserAction (get #id user)}>{get #name user}</a>
            , {get #createdAt thread |> timeAgo}

            <span class="ml-1">in <a href={ShowTopicAction (get #id topic)} class="text-muted">{get #name topic}</a></span>
        </div>
    </div>
|]
    where
        user = get #userId thread
        topic = get #topicId thread
