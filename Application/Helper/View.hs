module Application.Helper.View (
    module IHP.LoginSupport.Helper.View
   ,renderMarkdown, badgeMap, renderBadge, renderBadgeFor
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
        Left error -> [hsx|{text}|]
        Right markdown ->
                markdown
                |> MMark.useExtension ghcSyntaxHighlighter
                |> MMark.render
                |> tshow
                |> preEscapedToHtml

badgeMap :: [(Badge, (Text, Text))]
badgeMap = [(IhpContributor, ("IHP Contributor", "badge badge-pill badge-info"))
           ,(IhpStickerOwner, ("IHP Sticker Owner","badge badge-pill badge-primary"))
           ,(DiTeam, ("di Team","badge badge-pill badge-light"))
           ,(DiPartner, ("di Partner", "badge badge-pill badge-success"))
           ,(ForumSamaritan, ("Forum Samaritan", "badge badge-pill badge-secondary"))
           ]

-- | Render a badge unconditionally
renderBadge :: UserBadge -> Html
renderBadge userbadge = [hsx| <span class={snd badgeTuple}> {fst badgeTuple} </span> |]
    where badgeTuple = fromMaybe ("", "") (lookup userbadge.badge badgeMap)

-- | Render a badge only if it belongs to the given user
renderBadgeFor :: [User] -> User -> UserBadge -> Html
renderBadgeFor users forUser userbadge
    | badgeOwner.id == forUser.id = renderBadge userbadge
    | otherwise = [hsx||]
    where
        badgeOwner = case find (\u -> u.id == userbadge.userId) users of
            Just u -> u
            Nothing -> forUser
