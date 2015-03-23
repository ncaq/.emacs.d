;; -*- lexical-binding: t -*-

(custom-set-variables
 '(user-full-name     "ncaq")
 '(user-mail-address  "ncaq@ncaq.net"))

(custom-set-variables
 '(message-send-mail-function  'smtpmail-send-it)
 '(smtpmail-smtp-server        "ncaq.net")
 '(smtpmail-smtp-service       587)
 '(smtpmail-smtp-user          "ncaq")
 '(smtpmail-stream-type        'starttls)
 )
