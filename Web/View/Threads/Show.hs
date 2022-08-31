module Web.View.Threads.Show where
import Web.View.Prelude
import Application.Helper.View (badgeMap)

data ShowView = ShowView
    { thread :: Include "userId" Thread
    , comments :: [Include "userId" Comment]
    , badges :: [Include "userId" UserBadge]
    }

instance View ShowView where
    beforeRender ShowView { .. } = do
        setTitle (thread.title <> " - IHP Forum")

    html ShowView { .. } = [hsx|
        <div class="row thread mb-5">
            <div class="col-3 user-col">
                <a class="user-col" href={ShowUserAction author.id}>
                    {renderPicture author}
                    {author.name}
                </a>
                <tr> {forEach badges (renderBadges author)} </tr>
                {when (Just thread.userId.id == fmap (.id) currentUserOrNothing) threadOptions}
            </div>

            <div class="col-9 thread-content">
                <div class="text-muted thread-created-at">
                    {timeAgo thread.createdAt}
                </div>
                <h1 class="thread-title">{thread.title}</h1>
                <div class="thread-body">{renderMarkdown thread.body}</div>
            </div>
        </div>

        {forEach comments renderComment}


        <div class="row new-comment">
            <div class="col-3">
            </div>

            <div class="col-9 mb-5 text-center">
                <a class="btn btn-primary" href={NewCommentAction thread.id}>Add Comment</a>
            </div>
        </div>
    |]

        where
            threadOptions = [hsx|
                <p class="mt-3">
                    <a href={EditThreadAction thread.id} class="text-muted d-block">Edit thread</a>
                    <a href={DeleteThreadAction thread.id} class="text-muted js-delete d-block">Delete this thread</a>
                </p>
            |]

            author = thread.userId

            renderBadges author userbadge
                     | (author == userbadge.userId) = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
                        where
                            badgeTuple = fromMaybe ("", "") (lookup userbadge.badge badgeMap)
            renderBadges _ _ = [hsx||]

            renderComment comment = [hsx|
                <div class="row comment">
                    <div class="col-3 user-col">
                        {renderPicture comment.userId}
                        {comment.userId.name}
                        <tr> {forEach badges (renderBadges comment.userId)} </tr>
                    </div>

                    <div class="col-9">
                        <div class="comment-meta">
                            {timeAgo comment.createdAt}

                            {when currentUserIsAuthor commentActions}
                        </div>
                        <div class="comment-body">{renderMarkdown comment.body}</div>

                    </div>
                </div>
            |]
                where
                    currentUserIsAuthor = Just comment.userId.id == (fmap (.id) currentUserOrNothing)
                    commentActions = [hsx|
                        <a href={EditCommentAction comment.id}>Edit Comment</a>
                        <a href={DeleteCommentAction comment.id} class="js-delete">Delete Comment</a>
                    |]
