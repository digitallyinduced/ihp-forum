module Web.View.Comments.Show where
import Web.View.Prelude

data ShowView = ShowView { comment :: Comment }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show Comment</h1>
    |]
