;; -*- lexical-binding: t -*-
(require 'helm-gtags)
(custom-set-variables
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t))

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook          'helm-gtags-mode)
(add-hook 'c++-mode-hook        'helm-gtags-mode)
(add-hook 'asm-mode-hook        'helm-gtags-mode)
(add-hook 'emacs-lisp-mode-hook 'helm-gtags-mode)

;; key bindings
(define-key helm-gtags-mode-map (kbd "C-.")   'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "C->")   'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "C-c .") 'gtags-visit-rootdir)
(define-key helm-gtags-mode-map (kbd "M-.")   'helm-gtags-pop-stack)

(require 'auto-complete)
(defun ncaq/add-to-ac-sources-gtags ()
  (add-to-list 'ac-sources 'ac-source-gtags))
(add-hook 'helm-gtags-mode-hook 'ncaq/add-to-ac-sources-gtags)