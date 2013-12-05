(require 'd-mode)
(require 'flycheck-autoloads)
(require 'auto-complete)

(defun ncaq-d-mode-setup ()
  (define-key d-mode-map [remap code-format] 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)

(add-to-list 'ac-modes 'd-mode)
