(require 'recentf)

(custom-set-variables '(recentf-save-file "~/Dropbox/sync/.recentf"))
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 500)

(recentf-mode 1)
(require 'recentf-ext)
(require 'recentf-purge-tramp)
