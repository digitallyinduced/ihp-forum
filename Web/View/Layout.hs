module Web.View.Layout (defaultLayout, Html, renderPicture) where

import IHP.ViewPrelude
import IHP.Environment
import qualified Text.Blaze.Html5            as H
import qualified Text.Blaze.Html5.Attributes as A
import Web.Types
import Web.Routes
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

    <title>IHP Forum</title>
</head>
<body>
    <div class="container mt-4">
        <nav class="navbar navbar-expand-lg navbar-light mb-4">
            <a class="navbar-brand" href="/">λ IHP Forum</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link active" href={ThreadsAction}>Start</a>
                    <a class="nav-link active" href={TopicsAction}>Topics</a>
                    <div class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Links
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <a target="_blank" class="dropdown-item" href="https://github.com/digitallyinduced/ihp">IHP GitHub</a>
                            <a target="_blank" class="dropdown-item" href="https://ihp.digitallyinduced.com/">IHP Website</a>
                            <a target="_blank" class="dropdown-item" href="https://github.com/digitallyinduced/ihp-forum">IHP Forum GitHub</a>
                            <a target="_blank" class="dropdown-item" href="https://ihp.digitallyinduced.com/api-docs/">API Docs</a>
                            <a target="_blank" class="dropdown-item" href="https://digitallyinduced.us10.list-manage.com/subscribe?u=03763c34fa6aaa4c52edfe6ce&id=a09e22a2d3">Newsletter</a>
                            <a target="_blank" class="dropdown-item" href="https://gitter.im/digitallyinduced/ihp?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge">Gitter</a>
                            <a target="_blank" class="dropdown-item" href="https://www.digitallyinduced.com/imprint.html">Imprint</a>
                        </div>
                    </div>
                </div>
            </div>
            {renderLoggedInAs currentUserOrNothing}

            <div class="navbar-nav ml-auto">
                <a href={pathTo NewThreadAction} class="btn btn-primary ml-4">+ New Thread</a>
            </div>
        </nav>

        {renderFlashMessages}
        {inner}
    </div>

    <footer style="margin-top: 3rem; background-color: #073642; padding-top: 2rem; padding-bottom: 2rem; color:hsla(196, 13%, 96%, 1)">
        <div class="container">
            <div class="footer-nav">
                <a href="https://github.com/digitallyinduced/ihp">GitHub</a>
                <a href="https://ihp.digitallyinduced.com//Guide/">Guide</a>
                <a href="https://ihp.digitallyinduced.com//api-docs/">API</a>
                <a href="https://www.digitallyinduced.com/imprint.html">Imprint</a>

                <a href="https://www.digitallyinduced.com/">© 2020, digitally induced GmbH</a>
            </div>


            <a id="ihp-cloud-logo" href="https://ihpcloud.com/" target="_blank">
                <img src="https://ihpcloud.com/deployed-with-ihp-cloud-white.svg" alt="Deployed with IHP Cloud"/>
            </a>
        </div>

    </footer>
</body>
|]

renderLoggedInAs :: Maybe User -> Html
renderLoggedInAs (Just user) = [hsx|
<div class="navbar-nav">
    <div class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Logged in as: {get #name user}
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href={EditUserAction (get #id user)}>Update Profile</a>
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
    <div class="nav-item">
        <a class="nav-link" href={NewUserAction}>Sign Up</a>
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
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="TODO"/>
    <meta property="og:description" content="TODO"/>
|]


renderPicture :: User -> Html
renderPicture user = preEscapedToHtml ("<?xml version=\"1.0\" encoding=\"utf-8\"?>" :: Text) <> [hsx|
        <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 122 122" class="user-picture">
            <circle id="Oval" fill="#073642" cx="61" cy="61" r="60" class="icon"></circle>
            <text x="50%" y="60%" text-anchor="middle" line-spacing="60" letter-spacing="1.481481" style="font: bold 200% sans-serif" fill="hsla(196, 13%, 80%, 1)" class="icon">{text}</text>
        </svg>
    |]
        where text = get #name user
