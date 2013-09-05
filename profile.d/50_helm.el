(require 'helm-config)
(helm-mode 1)

(require 'helm-descbinds)
(helm-descbinds-mode)

(require 'helm-ag)

;;縦(右)に表示する
(setq helm-split-window-default-side 'right)
