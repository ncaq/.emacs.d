;; -*- lexical-binding: t -*-
(require 'yasnippet)
(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "M-'") 'helm-yas-complete)