;; -*- lexical-binding: t -*-

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-d") 'eglot-help-at-point)
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-code-actions)
  )
