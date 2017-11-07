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

(defun open-entry ()
  (interactive)
  (cl-flet ((entry-path (number)
                        (concat
                         "~/Desktop/www.ncaq.net/entry/"
                         (format-time-string "%Y-%m-%d" (current-time)) "-"
                         (number-to-string number) ".md")))
    (let ((n 1))
      (while (file-exists-p (entry-path n))
        (setq n (1+ n)))
      (find-file (entry-path n)))))

(yas-global-mode t)
