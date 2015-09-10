;; -*- lexical-binding: t -*-
;;http://cx4a.org/software/auto-complete/manual.ja.html

(require 'auto-complete-config)

(ac-config-default)

(custom-set-variables
 '(ac-auto-show-menu 0.4)
 '(ac-auto-start nil)
 '(ac-menu-height 22)
 '(ac-quick-help-delay 0.4)
 '(ac-use-quick-help t)
 '(global-auto-complete-mode t)
 '(ac-modes (append '(fundamental-mode
                      inferior-emacs-lisp-mode
                      text-mode
                      )))
 )

(setq-default ac-sources '(ac-source-filename
                           ac-source-words-in-all-buffer
                           ))

(defun turn-on-auto-complete-mode ()
  (auto-complete-mode t))

(add-hook 'find-file-hook 'turn-on-auto-complete-mode)

(ac-set-trigger-key "<tab>")
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-t") 'ac-previous)
(define-key ac-completing-map (kbd "RET") 'nil)
(define-key ac-mode-map       (kbd "C-'") 'auto-complete)
