;; -*- lexical-binding: t -*-

(require 'lsp-mode)

(add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))

(add-hook 'rustic-mode-hook 'racer-mode)
(add-hook 'racer-mode-hook 'eldoc-mode)

;; lsp-rust-enableが消滅したのでバッドノウハウとしてダミーの関数を定義する
(unless (fboundp 'lsp-rust-enable)
  (defun lsp-rust-enable ()
    ()))

(with-eval-after-load 'racer
  (define-key racer-mode-map (kbd "C-c C-d") 'racer-describe))
