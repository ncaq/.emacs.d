(require 'd-mode)
(require 'auto-complete)

(add-to-list 'ac-modes 'd-mode)

(defun ncaq-d ()
  (define-key d-mode-map [remap indent-whole-buffer] 'indent-brackets-whole-buffer))
(add-hook 'd-mode-hook 'ncaq-d)
