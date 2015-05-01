;; -*- lexical-binding: t -*-

(require 'auto-sudoedit-autoloads)
(require 'eww-goto-alc-autoloads)
(require 'help-fns+)
(require 'ncaq-emacs-utils)
(require 'symbolword-mode)

(autoload 'sudden-death "sudden-death")

(require 'mozc)
(custom-set-variables
 '(default-input-method 'japanese-mozc)
 '(mozc-candidate-style 'echo-area)
 )

(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 )

(with-eval-after-load 'skype
  (setq skype--my-user-handle "ncaq__"))
