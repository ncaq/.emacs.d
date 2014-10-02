;; -*- lexical-binding: t -*-

(custom-set-variables
 '(auto-mode-alist
   (append
    '(
      ("\\.html\\'"   . web-mode)
      ("\\.xhtml\\'"  . web-mode)
      )
    auto-mode-alist)))

(eval-after-load 'web-mode
  '(progn
    (define-key web-mode-map (kbd "M-c") 'web-mode-element-close)
    ))
