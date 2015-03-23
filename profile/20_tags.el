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

  ;; monkey patch
  (defun helm-gtags--read-tagname (type &optional default-tagname)
    (let ((tagname (helm-gtags--token-at-point type))
          (prompt (assoc-default type helm-gtags--prompt-alist))
          (comp-func (assoc-default type helm-gtags-comp-func-alist)))
      (if (and tagname helm-gtags-use-input-at-cursor)
          tagname
        (when (and (not tagname) default-tagname)
          (setq tagname default-tagname))
        (when tagname
          (setq prompt (format "%s(default \"%s\") " prompt tagname)))
        (let ((completion-ignore-case helm-gtags-ignore-case))
          (completing-read prompt comp-func nil nil nil
                           'helm-gtags--completing-history tagname)))))
  )

(add-hook 'c-mode-hook    'helm-gtags-mode)
(add-hook 'c++-mode-hook  'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook  'helm-gtags-mode)
