;; -*- lexical-binding: t -*-

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-normal ()
  (interactive)
  (helm-do-ag (or (helm-ag--project-root) default-directory)))
