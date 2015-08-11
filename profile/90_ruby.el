;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(inf-ruby-mode) ac-modes))
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding")
 )

(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

(with-eval-after-load 'ruby-mode (ncaq-set-key ruby-mode-map))
