(require 'd-mode)
(require 'flycheck)
(require 'auto-complete)

(defun ncaq-d-mode-setup ()
  (flycheck-mode)
  (local-set-key (kbd "M-z") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)

(add-to-list 'ac-modes 'd-mode)
