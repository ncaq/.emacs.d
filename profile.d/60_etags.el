(require 'helm-tags)

(defun helm-etags-setup ()
  (local-set-key (kbd "C-.")	'helm-etags-select)
  (local-set-key (kbd "C-M-.")	'find-tag)
  (local-set-key (kbd "C-c .")	'visit-tags-table);;タグを再設定
  (local-set-key (kbd "M-.")	'pop-tag-mark))

(add-hook 'emacs-lisp-mode-hook 'helm-etags-setup)
