;; -*- lexical-binding: t -*-
(setq inhibit-startup-message);起動時の画面無効

(abbrev-mode -1)

(defun kill-scratch ()
  (kill-buffer "*scratch*"))
(add-hook 'after-init-hook 'kill-scratch);open-junk-fileがあるからscratchいらない
