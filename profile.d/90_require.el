;;有効化して2行ぐらい書くだけのものはここに全部ツッコむ
(autoload 'lispxmp "lispxmp");;xmpfilterのemacs lisp version
(autoload 'minibuf-isearch "minibuf-isearch-mode")
(autoload 'sudden-death "sudden-death");突然の死
(autoload 'wdired "wdired-mode")

(autoload 'open-junk-file "open-junk-file");;使い捨てないscratch
(defvar open-junk-file-directory)
(setq open-junk-file-directory "~/Documents/log/%Y_%m/")

(require 'git-commit-mode)
(require 'gitconfig-mode)
(require 'gitignore-mode)

(require 'text-adjust)

(require 'undo-tree);;undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'yasnippet);;定型文補完
(yas-global-mode 1)

(require 'auto-save-buffers);;本当の自動保存
(run-with-idle-timer 30 t 'auto-save-buffers)

(require 'zlc)
(zlc-mode t)

(require 'git-gutter-fringe)
(global-git-gutter-mode t)

(require 'wgrep)
(require 'ag)

(require 'root-tramp)
(require 'vs-move-beginning-of-line)
