;; -*- lexical-binding: t -*-

(require 'auto-sudoedit-autoloads)
(require 'ncaq-emacs-utils)
(require 'symbolword-mode)
(require 'w3m-goto-alc-autoloads)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'mozc)
(custom-set-variables
 '(default-input-method 'japanese-mozc)
 '(mozc-candidate-style 'echo-area)
 )
'(define-key mozc-mode-map (kbd "C-;") 'toggle-input-method)

(autoload 'sdic "sdic")
(autoload 'sudden-death "sudden-death")

(autoload 'open-junk-file "open-junk-file")
(custom-set-variables '(open-junk-file-format "~/Documents/log/%Y_%m/"))

(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))

(eval-after-load 'skype
  '(progn
     (setq skype--my-user-handle "ncaq__")
     ))
