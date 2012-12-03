;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
	 (local-set-key [?\C-,] 'gtags-find-tag-by-event)
	 ;; (local-set-key "\M-t" 'gtags-find-tag)
	 ;; (local-set-key "\M-r" 'gtags-find-rtag)
	 ;; (local-set-key "\M-s" 'gtags-find-symbol)
	 (local-set-key [?\M-,] 'gtags-pop-stack)
	 ))

;; gtagsコマンドを自動実行
(defadvice gtags-find-tag (before run-gtags activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "GTAGS")))
    (if (file-exists-p tag-file)
	(message "file exists")
      (shell-command "gtags . 2>/dev/null"))))

;; 保存時にGTAGS
(add-hook 'after-save-hook
	  '(lambda ()
	     (let ((tag-file (concat default-directory "GTAGS")))
	       (if (file-exists-p tag-file)
		   (shell-command "gtags . 2>/dev/null")))))
