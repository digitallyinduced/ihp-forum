module Application.Helper.View (
    -- To use the built in login:
    module IHP.LoginSupport.Helper.View
    , renderMarkdown, badgeMap
) where

-- Here you can add functions which are available in all your views

-- To use the built in login:
import IHP.Prelude
import IHP.ViewPrelude
import IHP.LoginSupport.Helper.View
import qualified Text.MMark as MMark
import Text.MMark.Extension.GhcSyntaxHighlighter
import Generated.Types

renderMarkdown text =
    case text |> MMark.parse "" of
        Left error -> "Something went wrong"
        Right markdown ->
                markdown
                |> MMark.useExtension ghcSyntaxHighlighter
                |> MMark.render
                |> tshow
                |> preEscapedToHtml

badgeMap = [(IhpContributor, ("IHP Contributor", "badge badge-pill badge-info"))
           ,(IhpStickerOwner, ("IHP Sticker Owner","badge badge-pill badge-primary"))
           ,(DiTeam, ("di Team","badge badge-pill badge-light"))
           ,(DiPartner, ("di Partner", "badge badge-pill badge-success"))
           ,(ForumSamaritan, ("Forum Samaritan", "badge badge-pill badge-secondary"))
           ]

