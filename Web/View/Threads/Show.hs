module Web.View.Threads.Show where
import Web.View.Prelude
import Application.Helper.View (badgeMap)

data ShowView = ShowView
    { thread :: Include "userId" Thread
    , comments :: [Include "userId" Comment]
    , badges :: [Include "userId" UserBadge]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <div class="row thread mb-5">
            <div class="col-3 user-col">
                <a class="user-col" href={ShowUserAction (get #id author)}>
                    {renderPicture author}
                    {get #name author}
                </a>
                <tr> {forEach badges (renderBadges author)} </tr>
                {when (Just (get #userId thread |> get #id) == fmap (get #id) currentUserOrNothing) threadOptions}
            </div>

            <div class="col-9 thread-content">
                <div class="text-muted thread-created-at">
                    {get #createdAt thread |> timeAgo}
                </div>
                <h1 class="thread-title">{get #title thread}</h1>
                <div class="thread-body">{get #body thread |> renderMarkdown}</div>
            </div>
        </div>

        {forEach comments renderComment}


        <div class="row new-comment">
            <div class="col-3">
            </div>

            <div class="col-9 mb-5 text-center">
                <a class="btn btn-primary" href={NewCommentAction (get #id thread)}>Add Comment</a>
            </div>
        </div>
    |]

        where
            threadOptions = [hsx|
                <p class="mt-3">
                    <a href={EditThreadAction (get #id thread)} class="text-muted d-block">Edit thread</a>
                    <a href={DeleteThreadAction (get #id thread)} class="text-muted js-delete d-block">Delete this thread</a>
                </p>
            |]

            author = get #userId thread

            renderBadges author userbadge
                     | (author == (get #userId userbadge)) = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                        where
                            badgeTuple = fromMaybe ("", "") (lookup (get #badge userbadge) badgeMap)
            renderBadges _ _ = [hsx||]

            renderComment comment = [hsx|
                <div class="row comment">
                    <div class="col-3 user-col">
                        {renderPicture (get #userId comment)}
                        {get #userId comment |> get #name}
                        <tr> {forEach badges (renderBadges (get #userId comment))} </tr>
                    </div>

                    <div class="col-9">
                        <div class="comment-meta">
                            {get #createdAt comment |> timeAgo}

                            {when currentUserIsAuthor commentActions}
                        </div>
                        <div class="comment-body">{get #body comment |> renderMarkdown}</div>

                    </div>
                </div>
            |]
                where
                    currentUserIsAuthor = Just (get #userId comment |> get #id) == (fmap (get #id) currentUserOrNothing)
                    commentActions = [hsx|
                        <a href={EditCommentAction (get #id comment)}>Edit Comment</a>
                        <a href={DeleteCommentAction (get #id comment)} class="js-delete">Delete Comment</a>
                    |]
