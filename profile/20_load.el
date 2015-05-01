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

(autoload 'text-adjust-selective "text-adjust")
(defun text-adjust-selective ()
  (interactive)
  (text-adjust-hankaku-buffer)
  (text-adjust-kutouten-buffer))
