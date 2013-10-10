(require 'magit)
(define-key magit-mode-map (kbd "S") (lambda () (interactive)(magit-stage-all 4)))

(require 'git-gutter-fringe)
(global-git-gutter-mode t)
