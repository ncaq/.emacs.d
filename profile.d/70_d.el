(require 'd-mode)
(require 'auto-complete)

(defun ncaq-d-mode-setup ()
  (define-key d-mode-map [remap indent-whole-buffer] 'indent-brackets-whole-buffer))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)

(add-to-list 'ac-modes 'd-mode)
