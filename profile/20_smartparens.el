;; -*- lexical-binding: t -*-
(require 'smartparens-config)

(smartparens-global-mode 1)
(show-smartparens-global-mode 1)

(custom-set-variables '(sp-autoescape-string-quote nil))

;; based on https://github.com/Fuco1/smartparens/wiki/Permissions
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (forward-line -1)
  (indent-according-to-mode)
  (forward-line 1)
  (indent-according-to-mode)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode)
  )

(sp-local-pair '(c-mode c++-mode objc-mode java-mode) "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

(define-key smartparens-mode-map (kbd "C-(") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-)") 'sp-slurp-hybrid-sexp)
(define-key smartparens-mode-map (kbd "M-(") 'sp-backward-barf-sexp)
(define-key smartparens-mode-map (kbd "M-)") 'sp-forward-barf-sexp)

(define-key smartparens-mode-map (kbd "M-u") 'sp-splice-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-raise-sexp)

(define-key smartparens-mode-map [remap forward-sexp]       'sp-forward-sexp)
(define-key smartparens-mode-map [remap backward-sexp]      'sp-backward-sexp)
(define-key smartparens-mode-map [remap kill-sexp]          'sp-kill-sexp)
(define-key smartparens-mode-map [remap backward-kill-sexp] 'sp-backward-kill-sexp)
