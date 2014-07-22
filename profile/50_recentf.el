;; -*- lexical-binding: t -*-
(require 'recentf)
(custom-set-variables
 '(recentf-max-saved-items 1000)
 '(recentf-exclude '("~$" "\\.elc$" "TAGS" "\\.backup" "\\.undohist" "trash")))
(recentf-mode 1)
(require 'recentf-ext)
(require 'recentf-purge-tramp)