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
  (ncaq-set-key enh-ruby-mode-map)
  (define-key enh-ruby-mode-map "C-j" 'nil)
  )
