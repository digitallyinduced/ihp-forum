module Web.View.Comments.New where
import Web.View.Prelude
import Application.Helper.View (renderBadgeFor)

data NewView = NewView
  { comment :: Comment
  , thread :: Thread
  , author :: User
  , badges :: [UserBadge]
  , badgeUsers :: [User]
  }

instance View NewView where
    html NewView { .. } = [hsx|
        <div class="row thread mb-5">
            <div class="col-3 user-col">
                <a class="user-col" href={ShowUserAction author.id}>
                    {renderPicture author}
                    {author.name}
                </a>
                <tr> {forEach badges (renderBadgeFor badgeUsers author)} </tr>
            </div>
            <div class="col-9 thread-content">
                <div class="text-muted thread-created-at">
                    {thread.createdAt |> timeAgo}
                </div>
                <h1 class="thread-title">{thread.title}</h1>
                <div class="thread-body">{renderMarkdown thread.body}</div>

            </div>
        </div>

        {renderForm comment}
    |]
      where
            renderForm comment = formFor comment [hsx|
                {hiddenField #threadId}
                {(textareaField #body) { fieldLabel = "Your Comment:", helpText = "You can use markdown here." } }
                {submitButton}
                <a class="ml-3 btn btn-secondary" href={ShowThreadAction thread.id}>Go back to Thread</a>
            |]
