module Web.View.Comments.Edit where
import Web.View.Prelude

data EditView = EditView
    { comment :: Comment
    , thread :: Include "userId" Thread
    , badges :: [Include "userId" UserBadge]
    }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <a href={ShowThreadAction (get #id thread)}>
            Go back to <q>{get #title thread}</q>
        </a>
        <h1>Edit Comment</h1>
        <div class="row thread mb-5">
            <div class="col-3 user-col">
                <a class="user-col" href={ShowUserAction (get #id author)}>
                    {renderPicture author}
                    {get #name author}
                </a>
                <tr> {forEach badges (renderBadges author)} </tr>
            </div>

            <div class="col-9 thread-content">
                <div class="text-muted thread-created-at">
                    {get #createdAt thread |> timeAgo}
                </div>
                <h1 class="thread-title">{get #title thread}</h1>
                <div class="thread-body">{get #body thread |> renderMarkdown}</div>
            </div>
        </div>

        {renderForm comment}
    |]
      where
            author = get #userId thread

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {hiddenField #threadId}
    {hiddenField #userId}
    {textareaField #body}
    {submitButton}
|]
            renderBadges author userbadge
                     | (author == (get #userId userbadge)) = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                        where
                            badgeTuple = fromMaybe ("", "") (lookup (get #badge userbadge) badgeMap)
            renderBadges _ _ = [hsx||]

