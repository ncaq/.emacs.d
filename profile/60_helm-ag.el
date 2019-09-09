;; -*- lexical-binding: t -*-

(require 'helm-ag)

(custom-set-variables
 '(helm-ag-base-command "rg --no-heading --smart-case")
 '(helm-grep-ag-command "rg --color=always --smart-case --no-heading --line-number %s %s %s")
 )

(advice-add 'helm-ag--save-current-context :after 'xref-push-marker-stack)

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-default ()
  (interactive)
  (if (helm-ag--project-root)
      (helm-do-ag-project-root)
    (helm-do-ag)))

(defun helm-do-ag-project-root-or-default-at-point ()
  (interactive)
  (let ((helm-ag-insert-at-point 'symbol))
    (helm-do-ag-project-root-or-default)))
