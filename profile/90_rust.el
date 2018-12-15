;; -*- lexical-binding: t -*-

(require 'lsp-mode)

;; rust-modeで開かれる時があるのでrustic-modeを末尾に追加し直す
(cl-delete-if (lambda (element) (equal (cdr element) 'rust-mode)) auto-mode-alist)
(cl-delete-if (lambda (element) (equal (cdr element) 'rustic-mode)) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))

(add-hook 'rustic-mode-hook 'racer-mode)
(add-hook 'racer-mode-hook 'eldoc-mode)

;; lsp-rust-enableが消滅したのでバッドノウハウとしてダミーの関数を定義する
(unless (fboundp 'lsp-rust-enable)
  (defun lsp-rust-enable ()
    ()))

(with-eval-after-load 'racer
  (define-key racer-mode-map (kbd "C-c C-d") 'racer-describe))
