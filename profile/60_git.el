;; -*- lexical-binding: t -*-

(custom-set-variables
 '(fill-column 100)
 '(global-git-gutter-mode t)
 )

(with-eval-after-load 'git-commit (swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
(with-eval-after-load 'git-rebase (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t"))))
(with-eval-after-load 'magit (swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
