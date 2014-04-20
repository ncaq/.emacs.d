(require 'd-mode)
(require 'auto-complete)

(add-to-list 'ac-modes 'd-mode)

(define-key d-mode-map [remap indent-whole-buffer] 'indent-whole-buffer-and-brackets)
