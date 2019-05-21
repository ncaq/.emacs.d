;; -*- lexical-binding: t -*-

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-d") 'eglot-help-at-point)
  (define-key eglot-mode-map (kbd "C-c C-e") 'eglot-reconnect)
  (define-key eglot-mode-map (kbd "C-c C-i") 'eglot-format)
  (define-key eglot-mode-map (kbd "C-c C-n") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-code-actions)
  )

(with-eval-after-load 'flymake
  (custom-set-variables
   '(flymake-error-bitmap nil)
   '(flymake-note-bitmap nil)
   '(flymake-warning-bitmap nil)
   )
  (set-face-underline 'flymake-error nil)
  (set-face-underline 'flymake-note nil)
  (set-face-underline 'flymake-warning nil)
  )
