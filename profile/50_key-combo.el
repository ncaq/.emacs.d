;; -*- lexical-binding: t -*-
(require 'key-combo)
(custom-set-variables '(key-combo-global-default nil))

(key-combo-define-hook 'haskell-mode-hook
                       'key-combo-common-load-default
                       key-combo-common-default)

(key-combo-load-default)
