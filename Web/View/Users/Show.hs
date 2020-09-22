module Web.View.Users.Show where
import Web.View.Prelude
import Web.View.Threads.Index (renderThread)

data ShowView = ShowView
    { user :: User
    , threads :: [Include' ["userId", "topicId"] Thread]
    , badges :: [Include "userBadges" Badge]
    }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <div class="mb-5">
            {renderPicture user}
            <h1>{get #name user}</h1>
            <a class="btn btn-outline-primary" href={githubUrl}>
                Show GitHub Profile
            </a>
            <div class="user-badges">
                {forEach badges renderBadge}
            </div>
        </div>

        <h2>Threads by {get #name user}</h2>
        {forEach threads renderThread}
    |]
        where
            githubUrl = ("https://github.com/" :: Text) <> get #githubName user
            
--renderBadge :: Badge -> Html
renderBadge badge = [hsx| <span class="badge badge-pill badge-primary"> {(fromMaybe "" (lookup badge badgeMap))} </span> |]
                     where 
                       badgeMap = [(IhpContributor, "IHP Contributor"::Text) 
                                   ,(IhpStickerOwner, "IHP Sticker Owner"::Text) 
                                   ,(DiTeam, "di Team"::Text)
                                   ,(DiPartner, "di Partner"::Text)
                                   ,(ForumSamaritan, "Forum Samaritan"::Text)
                                   ]  


