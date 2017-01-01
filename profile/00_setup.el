;; -*- lexical-binding: t -*-

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")
 '(gc-cons-percentage (* gc-cons-percentage 5))
 '(gc-cons-threshold (* gc-cons-threshold 5))
 '(inhibit-startup-screen t)
 '(init-loader-show-log-after-init nil)
 )

(require 'server)
(unless (server-running-p)
  (server-start))

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

(kill-buffer-if-exist "*Compile-Log*")
(kill-buffer-if-exist "*scratch*")
