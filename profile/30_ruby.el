;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))

(custom-set-variables
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding")
 )

(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

(with-eval-after-load 'auto-complete (add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

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
