module Web.Mail.Comments.NewCommentNotification where
import Web.View.Prelude
import IHP.MailPrelude

data NewCommentNotificationMail = NewCommentNotificationMail
    { comment :: Comment
    , user :: User
    , thread :: Thread
    }

instance BuildMail NewCommentNotificationMail where
    subject = "IHP Forum: New Comment on " <> title
        where
            title = ?mail
                |> get #thread
                |> get #title
    to NewCommentNotificationMail { .. } = Address { addressName = Just (get #name user), addressEmail = get #email user }
    from = "ihpforum@digitallyinduced.com"
    html NewCommentNotificationMail { .. } = [hsx|
        <body style="font-family: Helvetica, Arial, sans-serif; font-size: 16px; color: #073642; max-width: 600px">
            <p>
                <img src="https://forum.ihpapp.com/ihp.svg" height="30"/>
            </p>
            <strong style="font-size: 22px; color: #073642; font-weight: 800">IHP Forum: New Comment on <q>{get #title thread}</q></strong>
            <p>
                {get #body comment}
                <br />
                <span style="font-size: 12px">{get #name user}</span>
            </p>
            <br />

            <p style="height: 1px; width: 64px; background-color: #dee2e669"></p>

            <br>

            <table width="100%" cellspacing="0" cellpadding="0">
              <tr>
                  <td>
                      <table cellspacing="0" cellpadding="0">
                          <tr>
                              <td style="border-radius: 4px;" bgcolor="#0d6378">
                                  <a href={urlTo $ ShowThreadAction (get #id thread)} target="_blank" style="padding: 8px 12px; border: 1px solid #0948581a;border-radius: 2px;font-family: Helvetica, Arial, sans-serif;font-size: 14px; color: #ffffff;text-decoration: none;font-weight:bold;display: inline-block;">
                                      Open Thread on IHP Forum
                                  </a>
                              </td>
                          </tr>
                      </table>
                  </td>
              </tr>
            </table>
        </body>
    |]
