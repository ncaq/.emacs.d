;; -*- lexical-binding: t -*-

(require 'git-commit)
(require 'git-gutter)
(require 'git-rebase)
(require 'magit-mode)

(custom-set-variables
 '(fill-column 100)
 '(global-git-gutter-mode t)
 )

(swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t")))
(swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t")))
(swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t")))
