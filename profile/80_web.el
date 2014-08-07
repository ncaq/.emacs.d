;; -*- lexical-binding: t -*-
(require 'web-mode)

(custom-set-variables
 '(auto-mode-alist
   (append
    '(
      ("\\.html\\'"   . web-mode)
      ("\\.xhtml\\'"  . web-mode)
      )
    auto-mode-alist)))

(define-key web-mode-map (kbd "M-c") 'web-mode-element-close)
