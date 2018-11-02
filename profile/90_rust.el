;; -*- lexical-binding: t -*-

(custom-set-variables '(rust-format-on-save t))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))
