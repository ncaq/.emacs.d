;; -*- lexical-binding: t -*-

(require 'mozc-im)

(custom-set-variables
 '(default-input-method "japanese-mozc-im")
 '(mozc-candidate-style 'echo-area)
 )

(defun cursor-color-toggle ()
  (if current-input-method
      (set-face-background 'cursor "#00629D")
    (set-face-background 'cursor "#839496")))

(defun cursor-color-direct ()
  (set-face-background 'cursor "#839496"))

(add-hook 'input-method-activate-hook 'cursor-color-toggle)
(add-hook 'input-method-deactivate-hook 'cursor-color-direct)
(add-hook 'window-configuration-change-hook 'cursor-color-toggle)
