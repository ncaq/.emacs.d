;; -*- lexical-binding: t -*-

(custom-set-variables
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding")
 )

(with-eval-after-load 'ruby-mode (ncaq-set-key ruby-mode-map))
