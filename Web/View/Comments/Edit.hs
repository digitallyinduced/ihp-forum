module Web.View.Comments.Edit where
import Web.View.Prelude
import Application.Helper.View (badgeMap)

data EditView = EditView
    { comment :: Comment
    , thread :: Thread
    , author :: User
    , badges :: [UserBadge]
    , badgeUsers :: [User]
    }

instance View EditView where
    html EditView { .. } = [hsx|
        <div class="row thread mb-5">
            <div class="col-3 user-col">
                <a class="user-col" href={ShowUserAction author.id}>
                    {renderPicture author}
                    {author.name}
                </a>
                <tr> {forEach badges (renderBadges author)} </tr>
            </div>

            <div class="col-9 thread-content">
                <div class="text-muted thread-created-at">
                    {thread.createdAt |> timeAgo}
                </div>
                <h1 class="thread-title">{thread.title}</h1>
                <div class="thread-body">{thread.body |> renderMarkdown}</div>
            </div>
        </div>

        {renderForm comment}
    |]
      where
            lookupUser userId = find (\u -> u.id == userId) badgeUsers

            renderBadges :: User -> UserBadge -> Html
            renderBadges theAuthor userbadge =
                let badgeUser = fromMaybe theAuthor (lookupUser userbadge.userId)
                in if theAuthor.id == badgeUser.id
                    then [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                    else [hsx||]
                where
                    badgeTuple = fromMaybe ("", "") (lookup userbadge.badge badgeMap)

            renderForm comment = formFor comment [hsx|
                {hiddenField #threadId}
                {(textareaField #body) { fieldLabel = "Your Comment:", helpText = "You can use markdown here." } }
                {submitButton}
                <a class="ml-3 btn btn-secondary" href={ShowThreadAction thread.id}>Go back to Thread</a>
            |]
