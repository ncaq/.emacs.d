;; -*- lexical-binding: t -*-

(custom-set-variables
 '(gc-cons-percentage 10)               ; 10%以上作成したらGC
 '(gc-cons-threshold 16000000)          ; 16MB以上作成したらGC
 '(inhibit-startup-message t)           ; 起動時の画面無効
 )

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'server)
(unless (server-running-p)
  (server-start))

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

(kill-buffer-if-exist "*Compile-Log*")
(kill-buffer-if-exist "*scratch*")