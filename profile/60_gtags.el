;; -*- lexical-binding: t -*-
(require 'helm-gtags)
(custom-set-variables '(helm-gtags-auto-update t));タグファイルの自動更新

;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables '(helm-gtags-path-style 'relative))
(custom-set-variables '(helm-gtags-ignore-case t))

;; key bindings
(define-key helm-gtags-mode-map (kbd "C-.")	'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "C-c .")	'gtags-visit-rootdir)
(define-key helm-gtags-mode-map (kbd "C-M-.")	'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "C->")	'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "M-.")	'helm-gtags-pop-stack)
