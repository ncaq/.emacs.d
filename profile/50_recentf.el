;; -*- lexical-binding: t -*-
(require 'recentf)
(custom-set-variables
 '(recentf-max-saved-items 1000)
 '(recentf-exclude '(
                     "TAGS"
                     "\\.backup"
                     "\\.elc$"
                     "\\.o$"
                     "\\.undohist"
                     "trash"
                     "~$"
                     )))
(recentf-mode 1)
(require 'recentf-ext)
(require 'recentf-purge-tramp)

(run-with-idle-timer 900 t 'recentf-cleanup)
