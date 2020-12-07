module Web.View.Users.Show where
import Web.View.Prelude hiding (badges)
import Web.View.Threads.Index (renderThread)
import Application.Helper.View

data ShowView = ShowView
    { user :: User
    , threads :: [Include' ["userId", "topicId"] Thread]
    , badges :: [UserBadge]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <div class="mb-5">
            {renderPicture user}
            <h1>{get #name user}</h1>
            <a class="btn btn-outline-primary" href={githubUrl}>
                Show GitHub Profile
            </a>
            <div class="user-badges">
            <tr> {forEach badges renderBadges} </tr>
            </div>
        </div>

        <h2>Threads by {get #name user}</h2>
        {forEach threads renderThread}
    |]
        where
            githubUrl = ("https://github.com/" :: Text) <> get #githubName user

            renderBadges userbadge = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                        where
                            badgeTuple = fromMaybe ("", "") (lookup (get #badge userbadge) badgeMap)
