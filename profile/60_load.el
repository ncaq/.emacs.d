;; -*- lexical-binding: t -*-

(require 'auto-sudoedit-autoloads)
(require 'eww-goto-alc-autoloads)
(require 'help-fns+)
(require 'ncaq-emacs-utils)
(require 'symbolword-mode)

(defun open-ncaq-working-dir ()
  (interactive)
  (let ((find-file-visit-truename t))
    (find-file "~/Documents/current/")))

(yas-global-mode t)
