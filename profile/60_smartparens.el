;; -*- lexical-binding: t -*-
(require 'smartparens-config)

(smartparens-global-mode 1)
(show-smartparens-global-mode 1)

(custom-set-variables '(sp-escape-quotes-after-insert nil))

;; based on https://github.com/Fuco1/smartparens/wiki/Permissions
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

(define-key smartparens-mode-map (kbd "C-(") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-)") 'sp-slurp-hybrid-sexp)
(define-key smartparens-mode-map (kbd "M-(") 'sp-backward-barf-sexp)
(define-key smartparens-mode-map (kbd "M-)") 'sp-forward-barf-sexp)

(define-key smartparens-mode-map (kbd "M-k") 'sp-splice-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-raise-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-split-sexp)

(define-key smartparens-mode-map [remap backward-kill-sexp] 'sp-backward-kill-sexp)
(define-key smartparens-mode-map [remap backward-list]      'sp-backward-symbol)
(define-key smartparens-mode-map [remap backward-sexp]      'sp-backward-sexp)
(define-key smartparens-mode-map [remap beginning-of-defun] 'sp-backward-down-sexp)
(define-key smartparens-mode-map [remap end-of-defun]       'sp-down-sexp)
(define-key smartparens-mode-map [remap forward-list]       'sp-forward-symbol)
(define-key smartparens-mode-map [remap forward-sexp]       'sp-forward-sexp)
(define-key smartparens-mode-map [remap kill-sexp]          'sp-kill-sexp)
