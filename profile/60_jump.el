;; -*- lexical-binding: t -*-

(custom-set-variables
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 )

(defun gtags-dir? ()
  (locate-dominating-file default-directory "GTAGS"))

(defun helm-gtags-mode-when-gtags-dir ()
  (when (gtags-dir?)
    (helm-gtags-mode t)))

(add-hook 'find-file-hook 'helm-gtags-mode-when-gtags-dir)

(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "C-.") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "C->") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map [remap pop-tag-mark] 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map [remap xref-pop-marker-stack] 'helm-gtags-pop-stack)
  )

(defun etags-dir? ()
  (locate-dominating-file default-directory "TAGS"))

(defun helm-etags-mode-when-etags-dir ()
  (when (etags-dir?)
    (local-set-key (kbd "C-.") 'helm-etags-select)
    ))

(add-hook 'find-file-hook 'helm-etags-mode-when-etags-dir)

(custom-set-variables '(helm-ag-base-command "rg --no-heading --smart-case"))

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-normal ()
  (interactive)
  (helm-do-ag (or (helm-ag--project-root) default-directory)))

(add-hook 'rg-mode-hook 'wgrep-ag-setup)
