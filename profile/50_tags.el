;; -*- lexical-binding: t -*-
(require 'helm-gtags)
(custom-set-variables
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style 'relative))

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; key bindings
(define-key helm-gtags-mode-map (kbd "C-.")   'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "C-c .") 'gtags-visit-rootdir)
(define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "C->")   'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "M-.")   'helm-gtags-pop-stack)

(defun helm-etags-setup ()
  (local-set-key (kbd "C-.")   'helm-etags-select)
  (local-set-key (kbd "C-M-.") 'find-tag)
  (local-set-key (kbd "C-c .") 'visit-tags-table);;タグを再設定
  (local-set-key (kbd "M-.")   'pop-tag-mark))
(add-hook 'emacs-lisp-mode-hook 'helm-etags-setup)
