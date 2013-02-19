;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(setq gtags-suggested-key-mapping);http://d.hatena.ne.jp/Nos/20120723/1343204409
(setq gtags-auto-update t);タグファイルの自動更新

(defun ncaq-gtags ()
  (local-set-key (kbd "C-.") 'gtags-pop-stack)
  (local-set-key (kbd "C->") 'gtags-find-with-grep)
  (local-set-key (kbd "C-M-.") 'gtags-find-symbol)
  (local-set-key (kbd "M-.") 'anything-gtags-select))
(add-hook 'gtags-mode-hook 'ncaq-gtags)

(defvar c-mode-common-hook)
(add-hook 'c-mode-common-hook 'gtags-mode)
