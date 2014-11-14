;; -*- lexical-binding: t -*-

(with-eval-after-load 'helm-gtags
  (custom-set-variables
   '(helm-gtags-auto-update t)
   '(helm-gtags-ignore-case t)
   )

  (define-key helm-gtags-mode-map (kbd "C-.")   'helm-gtags-find-tag-from-here)
  (define-key helm-gtags-mode-map (kbd "C->")   'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "C-c .") 'gtags-visit-rootdir)
  (define-key helm-gtags-mode-map (kbd "M-.")   'helm-gtags-pop-stack)

  (defun ncaq/add-to-ac-sources-gtags ()
    (add-to-list 'ac-sources 'ac-source-gtags))
  (add-hook 'helm-gtags-mode-hook 'ncaq/add-to-ac-sources-gtags)
  )

(add-hook 'c-mode-hook    'helm-gtags-mode)
(add-hook 'c++-mode-hook  'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook  'helm-gtags-mode)
