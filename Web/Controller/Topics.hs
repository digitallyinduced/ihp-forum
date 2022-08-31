module Web.Controller.Topics where

import Web.Controller.Prelude
import Web.View.Topics.Index
import Web.View.Topics.New
import Web.View.Topics.Edit
import Web.View.Topics.Show
import Web.View.Topics.Index
import Web.View.Topics.New
import Web.View.Topics.Show
import Web.View.Topics.Edit

instance Controller TopicsController where
    action TopicsAction = do
        topics <- query @Topic
            |> orderByDesc #lastActivityAt
            |> fetch
        render IndexView { .. }

    action ShowTopicAction { topicId } = do
        topic <- fetch topicId
        threads <- topic.threads
            |> fetch
            >>= collectionFetchRelated #userId
            >>= collectionFetchRelated #topicId
        render ShowView { .. }

    action NewTopicAction = renderNotFound
    action CreateTopicAction = renderNotFound
    action (EditTopicAction _) = renderNotFound
    action (UpdateTopicAction _) = renderNotFound
    action (DeleteTopicAction _) = renderNotFound
