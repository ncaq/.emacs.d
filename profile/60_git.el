;; -*- lexical-binding: t -*-

(require 'magit)

(define-key magit-file-mode-map (kbd "C-x g") 'nil)

(swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t")))
(swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t")))

(with-eval-after-load 'git-rebase
  (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t"))))

(require 'git-gutter)
(custom-set-variables '(global-git-gutter-mode t))
