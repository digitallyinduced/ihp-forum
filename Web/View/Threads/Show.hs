module Web.View.Threads.Show where
import Web.View.Prelude
import Application.Helper.View (badgeMap, renderBadgeFor)

data ShowView = ShowView
    { thread :: Thread
    , author :: User
    , comments :: [Comment]
    , commentUsers :: [User]
    , badges :: [UserBadge]
    , badgeUsers :: [User]
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
                <tr> {forEach badges (renderBadgeFor allUsers author)} </tr>
                {when (Just thread.userId == fmap (.id) currentUserOrNothing) threadOptions}
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
            allUsers = author : commentUsers <> badgeUsers

            threadOptions = [hsx|
                <p class="mt-3">
                    <a href={EditThreadAction thread.id} class="text-muted d-block">Edit thread</a>
                    <a href={DeleteThreadAction thread.id} class="text-muted js-delete d-block">Delete this thread</a>
                </p>
            |]

            lookupUser :: Id User -> User
            lookupUser userId = fromMaybe author (find (\u -> u.id == userId) allUsers)

            renderComment :: Comment -> Html
            renderComment comment = [hsx|
                <div class="row comment">
                    <div class="col-3 user-col">
                        {renderPicture commentUser}
                        {commentUser.name}
                        <tr> {forEach badges (renderBadgeFor allUsers commentUser)} </tr>
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
                    commentUser = lookupUser comment.userId
                    currentUserIsAuthor = Just commentUser.id == (fmap (.id) currentUserOrNothing)
                    commentActions = [hsx|
                        <a href={EditCommentAction comment.id}>Edit Comment</a>
                        <a href={DeleteCommentAction comment.id} class="js-delete">Delete Comment</a>
                    |]
