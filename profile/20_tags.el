;; -*- lexical-binding: t -*-

(with-eval-after-load 'helm-gtags
  (custom-set-variables
   '(helm-gtags-auto-update t)
   '(helm-gtags-ignore-case t)
   '(helm-gtags-update-interval-second 15)
   )

  (define-key helm-gtags-mode-map (kbd "C-.")   'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "C->")   'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "C-c .") 'gtags-visit-rootdir)
  (define-key helm-gtags-mode-map (kbd "M-.")   'helm-gtags-pop-stack)
  )

(add-hook 'c-mode-hook       'helm-gtags-mode)
(add-hook 'c++-mode-hook     'helm-gtags-mode)
(add-hook 'java-mode-hook    'helm-gtags-mode)
(add-hook 'asm-mode-hook     'helm-gtags-mode)
(add-hook 'haskell-mode-hook 'helm-gtags-mode)
