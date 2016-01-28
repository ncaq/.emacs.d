;; -*- lexical-binding: t -*-

(custom-set-variables
 '(exec-path-from-shell-check-startup-files nil)
 '(gc-cons-percentage 1)
 '(gc-cons-threshold 8000000)
 '(inhibit-startup-screen t)
 )

(exec-path-from-shell-initialize)

(require 'server)
(unless (server-running-p)
  (server-start))

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

(kill-buffer-if-exist "*Compile-Log*")
(kill-buffer-if-exist "*scratch*")
