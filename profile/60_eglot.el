;; -*- lexical-binding: t -*-

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-d") 'eglot-help-at-point)
  (define-key eglot-mode-map (kbd "C-c C-n") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c C-i") 'eglot-format)
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-code-actions)
  )
