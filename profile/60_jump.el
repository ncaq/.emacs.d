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
  (define-key helm-gtags-mode-map (kbd "C-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "C->") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-select)
  (define-key helm-gtags-mode-map [remap pop-tag-mark] 'helm-gtags-pop-stack)
  )

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-normal ()
  (interactive)
  (helm-do-ag (or (helm-ag--project-root) default-directory)))