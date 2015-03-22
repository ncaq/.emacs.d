;; -*- lexical-binding: t -*-

(with-eval-after-load 'magit
  (custom-set-variables
   '(fill-column 160)
   '(git-commit-fill-column 160)
   '(git-commit-mode-hook nil)
   '(git-commit-summary-max-length 160)
   '(magit-diff-refine-hunk 'all)
   ))

(global-git-gutter+-mode 1)
(custom-set-variables '(git-gutter+:verbosity 2))
