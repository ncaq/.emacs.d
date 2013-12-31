(require 'magit)

(remove-hook 'git-commit-mode-hook 'turn-on-auto-fill)

(require 'git-gutter-fringe)
(global-git-gutter-mode t)
