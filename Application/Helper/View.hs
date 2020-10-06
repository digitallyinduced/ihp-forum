module Application.Helper.View (
    module IHP.LoginSupport.Helper.View
   ,renderMarkdown, badgeMap
   ,currentAdmin, currentAdminOrNothing
) where

-- Here you can add functions which are available in all your views
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

currentAdmin :: (?viewContext :: viewContext, HasField "admin" viewContext (Maybe admin)) => admin
currentAdmin = fromMaybe (error "Application.Helper.View.currentAdmin: Not logged in") currentAdminOrNothing

currentAdminOrNothing :: (?viewContext :: viewContext, HasField "admin" viewContext (Maybe admin)) => Maybe admin
currentAdminOrNothing = getField @"admin" ?viewContext 


