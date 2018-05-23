;; -*- lexical-binding: t -*-

(require 'flycheck-ensime)

(custom-set-variables '(ensime-startup-notification nil))

(define-key ensime-mode-map (kbd "M-n") nil)
(define-key ensime-mode-map (kbd "M-p") nil)
