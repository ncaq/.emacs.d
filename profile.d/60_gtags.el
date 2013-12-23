(require 'gtags)
(setq gtags-auto-update t);タグファイルの自動更新

(require 'helm-gtags)
;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)

;; key bindings
(defun ncaq-gtags ()
  (define-key helm-gtags-mode-map (kbd "C-.")	'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "C-c .")	'gtags-rootdir)
  (define-key helm-gtags-mode-map (kbd "C-M-.")	'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "C->")	'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-.")	'helm-gtags-pop-stack))
(add-hook 'helm-gtags-mode-hook 'ncaq-gtags)
