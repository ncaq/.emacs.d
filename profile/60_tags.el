;; -*- lexical-binding: t -*-

(with-eval-after-load 'helm-gtags
  (custom-set-variables
   '(helm-gtags-auto-update t)
   '(helm-gtags-ignore-case t)
   '(helm-gtags-update-interval-second 15)
   )

  (define-key helm-gtags-mode-map (kbd "C-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "C->") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-select)
  (define-key helm-gtags-mode-map [remap pop-tag-mark] 'helm-gtags-pop-stack)
  )

(defun gtags-or-imenu (arg)
  (interactive "P")
  (if (locate-dominating-file default-directory "GTAGS")
      (progn (helm-gtags-mode)
             (helm-gtags-dwim))
    (helm-semantic-or-imenu arg)))
