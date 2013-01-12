;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)

;; gtagsコマンドを自動実行
(defun my-c-mode-update-gtags ()
  (let* ((file (buffer-file-name (current-buffer)))
	 (dir (directory-file-name (file-name-directory file))))
    (when (executable-find "global")
      (start-process "gtags-update" nil
		     "global" "-uv"))))

(add-hook 'after-save-hook
	  'my-c-mode-update-gtags)
