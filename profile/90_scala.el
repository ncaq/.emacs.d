;; -*- lexical-binding: t -*-

(defun scala-mode-setting ()
  (add-hook 'after-save-hook 'lsp-format-buffer nil t))

(with-eval-after-load 'scala-mode
  (add-hook 'scala-mode-hook 'lsp)
  (add-hook 'scala-mode-hook 'scala-mode-setting))
