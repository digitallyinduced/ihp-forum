module Web.View.Users.Show where
import Web.View.Prelude hiding (badges)
import Application.Helper.View

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
            <tr> {forEach badges renderBadges} </tr>
            </div>
        </div>

        <h2>Threads by {user.name}</h2>
        {forEach threads renderThread}
    |]
        where
            githubUrl = ("https://github.com/" :: Text) <> user.githubName

            lookupUser userId = find (\u -> u.id == userId) threadUsers
            lookupTopic topicId = find (\t -> t.id == topicId) threadTopics

            renderBadges userbadge = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                        where
                            badgeTuple = fromMaybe ("", "") (lookup userbadge.badge badgeMap)

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
                    Just u -> [hsx|<a class="text-muted" href={ShowUserAction u.id}>{u.name}</a>|]
                    Nothing -> [hsx||]
                renderTopic topicId = case lookupTopic topicId of
                    Just topic -> [hsx|<span class="ml-1">in <a href={ShowTopicAction topic.id} class="text-muted">{topic.name}</a></span>|]
                    Nothing -> [hsx||]
