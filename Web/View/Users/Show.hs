module Web.View.Users.Show where
import Web.View.Prelude hiding (badges)
import Web.View.Threads.Index (renderThread)
import Application.Helper.View (badgeMap, renderBadge)

data ShowView = ShowView
    { user :: User
    , threads :: [Thread]
    , threadUsers :: [User]
    , threadTopics :: [Topic]
    , badges :: [UserBadge]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <div class="mb-5">
            {renderPicture user}
            <h1>{user.name}</h1>
            <a class="btn btn-outline-primary" href={githubUrl}>
                Show GitHub Profile
            </a>
            <div class="user-badges">
            <tr> {forEach badges renderBadge} </tr>
            </div>
        </div>

        <h2>Threads by {user.name}</h2>
        {forEach threads (renderThread threadUsers threadTopics)}
    |]
        where
            githubUrl = ("https://github.com/" :: Text) <> user.githubName
