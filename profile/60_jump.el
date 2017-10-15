;; -*- lexical-binding: t -*-

(defun etags-dir? ()
  (locate-dominating-file default-directory "TAGS"))

(defun etags-mode-when-etags-dir ()
  (when (etags-dir?)
    (local-set-key (kbd "C-.") 'helm-etags-select)
    ))

(add-hook 'find-file-hook 'etags-mode-when-etags-dir)

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-normal ()
  (interactive)
  (helm-do-ag (or (helm-ag--project-root) default-directory)))
