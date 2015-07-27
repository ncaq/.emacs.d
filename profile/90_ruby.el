;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))

(custom-set-variables
 '(ac-modes (append '(enh-ruby-mode inf-ruby-mode) ac-modes))
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding")
 )

(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

(with-eval-after-load 'enh-ruby-mode
  (define-key enh-ruby-mode-map "C-j" 'nil)
  (define-key enh-ruby-mode-map "C-M-q" 'nil)

  (define-key enh-ruby-mode-map "C-M-b" 'nil)
  (define-key enh-ruby-mode-map "C-M-h" 'enh-ruby-backward-sexp)

  (define-key enh-ruby-mode-map "C-M-f" 'nil)
  (define-key enh-ruby-mode-map "C-M-s" 'enh-ruby-forward-sexp)

  (define-key enh-ruby-mode-map "C-M-p" 'nil)
  (define-key enh-ruby-mode-map "C-M-t" 'enh-ruby-beginning-of-block)
  )
