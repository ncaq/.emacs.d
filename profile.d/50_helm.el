(require 'helm-config)
(helm-mode 1)
(require 'helm)

(require 'helm-ag)

(require 'helm-descbinds)
mov(helm-descbinds-mode)

;;tramp周りにバグがある
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
