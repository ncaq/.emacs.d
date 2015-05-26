;; -*- lexical-binding: t -*-
;;http://cx4a.org/software/auto-complete/manual.ja.html

(require 'auto-complete-config)

(ac-config-default)

(custom-set-variables
 '(global-auto-complete-mode t)
 '(ac-auto-show-menu 0.4)
 '(ac-auto-start nil)
 '(ac-menu-height 22)
 '(ac-quick-help-delay 0.4)
 '(ac-use-quick-help t)
 '(ac-modes (append
             '(conf-mode
               d-mode
               fundamental-mode
               git-commit-mode
               graphviz-dot-mode
               haskell-mode
               inferior-emacs-lisp-mode
               inferior-haskell-mode
               markdown-mode
               nxml-mode
               plantuml-mode
               rust-mode
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
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-t") 'ac-previous)
(define-key ac-completing-map (kbd "RET") 'nil)
(define-key ac-mode-map       (kbd "C-'") 'auto-complete)
