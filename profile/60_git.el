;; -*- lexical-binding: t -*-

;; [cannot commit with git-commit-20191106.1247 · Issue #3997 · magit/magit](https://github.com/magit/magit/issues/3997)
(require 'subr-x)

(require 'git-commit)
(require 'git-gutter)
(require 'git-rebase)
(require 'magit-mode)

;; [cannot commit with git-commit-20191106.1247 · Issue #3997 · magit/magit](https://github.com/magit/magit/issues/3997)
(require 'subr-x)

(custom-set-variables '(global-git-gutter-mode t))

(define-key magit-file-mode-map (kbd "C-x g") 'nil)

(swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t")))
(swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t")))
(swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t")))
