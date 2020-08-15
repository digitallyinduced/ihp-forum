module Web.View.Users.Show where
import Web.View.Prelude
import Web.View.Threads.Index (renderThread)

data ShowView = ShowView
    { user :: User
    , threads :: [Include' ["userId", "topicId"] Thread]
    }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <div class="mb-5">
            {renderPicture user}
            <h1>{get #name user}</h1>
            <a class="btn btn-outline-primary" href={githubUrl}>
                Show GitHub Profile
            </a>
        </div>

        <h2>Threads by {get #name user}</h2>
        {forEach threads renderThread}
    |]

        where
            githubUrl = ("https://github.com/" :: Text) <> get #githubName user