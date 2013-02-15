;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(setq gtags-auto-update t);タグファイルの自動更新

(add-hook 'gtags-mode-hook
	     '(lambda ()
		(local-set-key (kbd "C-.") 'gtags-pop-stack)
		(local-set-key (kbd "C-M-.") 'gtags-find-symbol)
		(local-set-key (kbd "C->") 'gtags-find-with-grep)
		(local-set-key (kbd "M-.") 'anything-gtags-select)
		))
