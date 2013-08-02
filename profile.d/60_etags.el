(autoload 'anything-yaetags "ncaq-etags")
(defun ncaq-etags ()
  (local-set-key (kbd "C-.") 'anything-c-etags-select)
  (local-set-key (kbd "M-.") 'pop-tag-mark))
(add-hook 'lisp-mode-hook 'ncaq-etags)
(add-hook 'emacs-lisp-mode-hook 'ncaq-etags)

;;emacsで保存した時にetags更新
(defun etags-update ()
  (if (file-exists-p "./TAGS")
      (shell-command-to-string "ctags-exuberant -e --exclude='*.elc' *")));etagsはExuberantじゃない
(add-hook 'after-save-hook 'etags-update)
