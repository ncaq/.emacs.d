;; -*- lexical-binding: t -*-

(custom-set-variables
 '(fill-column 160)
 '(git-commit-fill-column 160)
 '(git-commit-summary-max-length 160)
 '(global-git-gutter+-mode t)
 )

(with-eval-after-load 'git-commit (ncaq-set-key git-commit-mode-map))
(with-eval-after-load 'git-rebase (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t"))))
(with-eval-after-load 'magit (ncaq-set-key magit-mode-map))
