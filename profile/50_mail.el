;; -*- lexical-binding: t -*-

(custom-set-variables
 '(user-full-name     "ncaq")
 '(user-mail-address  "ncaq@ncaq.net"))

(require 'mu4e)
(custom-set-variables
 '(mu4e-maildir               "~/.maildir")
 '(mu4e-drafts-folder         "/Drafts")
 '(mu4e-sent-folder           "/Sent")
 '(mu4e-trash-folder          "/Trash")
 
 '(mu4e-get-mail-command      "offlineimap")
 '(mu4e-html2text-command     "pyhtml2text --body-width=0")
 
 '(mu4e-refile-folder         nil)
 '(mu4e-update-interval       1000)
 '(mu4e-view-image-max-width  800)
 '(mu4e-view-prefer-html      t)
 '(mu4e-view-show-images      t)
 )

(defun mu4e-jump-to-inbox ()
  (interactive)
  (mu4e~headers-jump-to-maildir "/INBOX"))

(define-key mu4e-view-mode-map (kbd "M-q") 'nil)

(require 'smtpmail)
(custom-set-variables
 '(message-send-mail-function  'smtpmail-send-it)
 '(smtpmail-smtp-server        "ncaq.net")
 '(smtpmail-smtp-service       587)
 '(smtpmail-smtp-user          "ncaq")
 '(smtpmail-stream-type        'starttls)
 )
