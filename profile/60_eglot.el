;; -*- lexical-binding: t -*-

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((css-mode sass-mode scss-mode less-css-mode) . ("css-languageserver" "--stdio")))
  (add-to-list 'eglot-server-programs (cons 'web-mode (cdr (assoc '(js-mode typescript-mode) eglot-server-programs))))

  (define-key eglot-mode-map (kbd "C-c C-d") 'eglot-help-at-point)
  (define-key eglot-mode-map (kbd "C-c C-e") 'eglot-reconnect)
  (define-key eglot-mode-map (kbd "C-c C-i") 'eglot-format)
  (define-key eglot-mode-map (kbd "C-c C-n") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-code-actions)
  )
