module Web.View.Topics.Show where
import Web.View.Prelude
import Web.View.Threads.Index (renderThread)

data ShowView = ShowView
    { topic :: Topic
    , threads :: [Include' ["userId", "topicId"] Thread]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>{topic.name}</h1>

        <div class="threads">
            {forEach threads renderThread}
        </div>
        {whenEmpty threads emptyTopic}
    |]

emptyTopic = [hsx|
    <div class="text-muted text-center p-5 h3">
        No threads in this topic yet, be the first one to change this! :)
        <a href={NewThreadAction} class="btn btn-primary mt-4">+ New Thread</a>
    </div>
|]
