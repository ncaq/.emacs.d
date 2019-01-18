;; -*- lexical-binding: t -*-

(custom-set-variables
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding")
 '(ruby-insert-encoding-magic-comment nil)
 )

(with-eval-after-load 'ruby-mode
  (add-hook 'ruby-mode-hook 'eglot-ensure)
  (ncaq-set-key ruby-mode-map))
