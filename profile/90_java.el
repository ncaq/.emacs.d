;; -*- lexical-binding: t -*-

(with-eval-after-load 'cc-mode
  (require 'lsp-java)
  (add-hook 'java-mode-hook 'lsp))
