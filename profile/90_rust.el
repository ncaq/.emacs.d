;; -*- lexical-binding: t -*-

(require 'lsp-mode)

(add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))

(add-hook 'rustic-mode-hook 'racer-mode)
(add-hook 'racer-mode-hook 'eldoc-mode)

(with-eval-after-load 'racer
  (define-key racer-mode-map (kbd "C-c C-d") 'racer-describe))
