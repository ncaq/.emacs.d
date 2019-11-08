;; -*- lexical-binding: t -*-

(with-eval-after-load 'lsp-mode
  (custom-set-variables
   '(lsp-prefer-flymake nil))              ; flycheckを優先する

  (define-key lsp-mode-map (kbd "C-c C-d") 'lsp-describe-thing-at-point)
  (define-key lsp-mode-map (kbd "C-c C-e") 'lsp-workspace-restart)
  (define-key lsp-mode-map (kbd "C-c C-i") 'lsp-format-buffer)
  (define-key lsp-mode-map (kbd "C-c C-n") 'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c C-r") 'lsp-execute-code-action)
  )
