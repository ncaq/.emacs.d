(require 'd-mode)
(require 'flymake)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))

(defun ncaq-d-mode-setup ()
  (flycheck-mode)
  (local-set-key (kbd "C-c s") 'code-format-c)
  (local-set-key (kbd "M-z") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)

(require 'ac-dcd)
(add-to-list 'ac-modes 'd-mode)
(defun ac-d-mode-setup ()
  (setq ac-sources (append '(ac-source-dcd) ac-sources)))
(add-hook 'd-mode-hook 'ac-d-mode-setup)
