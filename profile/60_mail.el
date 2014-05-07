(custom-set-variables
 '(user-full-name "ncaq")
 '(user-mail-address "ncaq@ncaq.net"))

(require 'mu4e)
(custom-set-variables
 '(mu4e-maildir "~/.maildir")
 '(mu4e-drafts-folder "/Drafts")
 '(mu4e-sent-folder "/Sent")
 '(mu4e-trash-folder "/Trash")
 '(mu4e-get-mail-command "offlineimap")
 '(mu4e-html2text-command "w3m -dump -T text/html")
 '(mu4e-refile-folder nil)
 '(mu4e-update-interval 300)
 '(mu4e-view-show-images t)
 '(mu4e-view-image-max-width 800))

(require 'smtpmail)
(custom-set-variables
 '(message-send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-user "ncaq")
 '(smtpmail-smtp-server "ncaq.net")
 '(smtpmail-smtp-service 587)
 '(smtpmail-stream-type 'starttls))