;; -*- lexical-binding: t -*-

(require 'auto-sudoedit)
(auto-sudoedit-mode 1)

(require 'help-fns+)
(require 'ncaq-emacs-utils)
(require 'symbolword-mode)

(defun open-ncaq-working-dir ()
  (interactive)
  (let ((find-file-visit-truename t))
    (find-file "~/Documents/current/")))

(defun open-ncaq-entry ()
  (interactive)
  (find-file (concat "~/Desktop/www.ncaq.net/entry/"
                     (format-time-string "%Y-%m-%d-%H-%M-%S" (current-time)) ".md")))

(editorconfig-mode 1)
