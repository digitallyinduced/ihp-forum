module Admin.View.Layout (defaultLayout, Html) where

import IHP.ViewPrelude
import IHP.Environment
import qualified Text.Blaze.Html5            as H
import qualified Text.Blaze.Html5.Attributes as A
import Admin.Types
import Admin.Routes
import qualified IHP.FrameworkConfig as FrameworkConfig
import Config ()

import Application.Helper.View
import Generated.Types

defaultLayout :: Html -> Html
defaultLayout inner = H.docTypeHtml ! A.lang "en" $ [hsx|
<head>
    {metaTags}

    {stylesheets}
    {scripts}

    <title>App</title>
</head>
<body>
    <div class="container mt-4">
        {renderLoggedInAs currentAdminOrNothing}
        {renderFlashMessages}
        {inner}
    </div>
</body>
|]
    where
        currentAdminOrNothing = fromFrozenContext @(Maybe Admin)

renderLoggedInAs :: Maybe Admin -> Html
renderLoggedInAs (Just admin) = [hsx|
<div class="navbar-nav">
    <div class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Logged in as: {get #name admin}
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item js-delete js-delete-no-confirm" href={DeleteSessionAction}>Logout</a>
        </div>
    </div>
</div>
|]

renderLoggedInAs Nothing = [hsx|
<div class="navbar-nav">
    <div class="nav-item">
        <a class="nav-link" href={NewSessionAction}>Login</a>
    </div>
</div>
|]

stylesheets :: Html
stylesheets = do
    when isDevelopment [hsx|
        <link rel="stylesheet" href="/vendor/bootstrap.min.css"/>
        <link rel="stylesheet" href="/vendor/flatpickr.min.css"/>
        <link rel="stylesheet" href="/app.css"/>
    |]
    when isProduction [hsx|
        <link rel="stylesheet" href="/prod.css"/>
    |]

scripts :: Html
scripts = do
    when isDevelopment [hsx|
        <script id="livereload-script" src="/livereload.js"></script>
        <script src="/vendor/jquery-3.2.1.slim.min.js"></script>
        <script src="/vendor/timeago.js"></script>
        <script src="/vendor/popper.min.js"></script>
        <script src="/vendor/bootstrap.min.js"></script>
        <script src="/vendor/flatpickr.js"></script>
        <script src="/helpers.js"></script>
        <script src="/vendor/morphdom-umd.min.js"></script>
    |]
    when isProduction [hsx|
        <script src="/prod.js"></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="IHP Forum"/>
    <meta property="og:type" content="website"/>
    <!--<meta property="og:url" content=""/>-->
    <meta property="og:description" content="The place to share everything about IHP and the Haskellworld."/>
|]
