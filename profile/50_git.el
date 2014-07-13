;; -*- lexical-binding: t -*-

(require 'magit)
(delq 'Git vc-handled-backends)
(remove-hook 'find-file-hooks 'vc-find-file-hook)

(custom-set-variables
 '(fill-column             160)
 '(git-commit-fill-column  160)
 '(git-commit-mode-hook    nil)
 )

(require 'git-gutter-fringe+)
(global-git-gutter+-mode 1)
(custom-set-variables '(git-gutter+:verbosity 2))