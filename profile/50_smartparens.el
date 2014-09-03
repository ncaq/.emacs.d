;; -*- lexical-binding: t -*-
(require 'smartparens-config)

(smartparens-global-mode 1)
(show-smartparens-global-mode 1)

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
