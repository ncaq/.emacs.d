(require 'magit)
(define-key magit-mode-map (kbd "S") (lambda () (interactive)(magit-stage-all 4)))

(remove-hook 'git-commit-mode-hook 'turn-on-auto-fill)

(require 'git-gutter-fringe)
(global-git-gutter-mode t)
