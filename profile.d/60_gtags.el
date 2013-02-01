;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)

(setq gtags-auto-update t);タグファイルの自動更新

(setq gtags-mode-hook
      '(lambda ()
         ;; (local-set-key "\M-t" 'gtags-find-tag)
         ;; (local-set-key "\M-r" 'gtags-find-rtag)
         ;; (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key (kbd "C-.") 'gtags-pop-stack)
         ))
