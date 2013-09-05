(require 'gtags)
(setq gtags-suggested-key-mapping);http://d.hatena.ne.jp/Nos/20120723/1343204409
(setq gtags-auto-update t);タグファイルの自動更新

(require 'helm-gtags)
;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)

;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
	     (local-set-key (kbd "C-.")		'helm-gtags-find-tag)
	     (local-set-key (kbd "C-M-.")	'helm-gtags-find-symbol)
	     (local-set-key (kbd "C-S-.")	'helm-gtags-find-rtag)
	     (local-set-key (kbd "M-.")		'helm-gtags-pop-stack)
	     (local-set-key (kbd "M-g C-.")	'helm-gtags-parse-file)))
