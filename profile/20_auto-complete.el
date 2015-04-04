;; -*- lexical-binding: t -*-
;;http://cx4a.org/software/auto-complete/manual.ja.html

(require 'auto-complete-config)

(ac-config-default)

(custom-set-variables
 '(global-auto-complete-mode t)
 '(ac-auto-show-menu 0.4)
 '(ac-menu-height 22)
 '(ac-quick-help-delay 0.4)
 '(ac-use-quick-help t)
 '(ac-modes (append
             '(conf-mode
               d-mode
               fundamental-mode
               git-commit-mode
               haskell-mode
               inferior-emacs-lisp-mode
               inferior-haskell-mode
               markdown-mode
               nxml-mode
               scss-mode
               shell-script-mode
               text-mode
               )
             ac-modes))
 )

(setq-default ac-sources '(ac-source-filename
                           ac-source-words-in-all-buffer
                           ))

(ac-set-trigger-key "<tab>")
(define-key ac-completing-map (kbd "M-p") 'ac-previous)
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "RET") 'nil)
(define-key ac-mode-map       (kbd "C-'") 'auto-complete)
