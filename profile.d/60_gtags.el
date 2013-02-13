;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(setq gtags-auto-update t);タグファイルの自動更新

(setq gtags-mode-hook
      '(lambda ()
         (local-set-key (kbd "C-M-.") 'gtags-find-rtag)
         (local-set-key (kbd "M-.") 'gtags-find-symbol)
         (local-set-key (kbd "C-.") 'gtags-pop-stack)
         ))
