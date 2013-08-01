;;requireして2行ぐらい書くだけのものはここに全部ツッコむ
(require 'grep-edit)
(require 'lispxmp);;xmpfilterのemacs lisp version
(require 'minibuf-isearch)
(require 'mode-compile);;かしこいコンパイル
(require 'sudden-death);突然の死
(require 'text-adjust)
(require 'wdired)

(require 'git-commit-mode)
(require 'gitconfig-mode)
(require 'gitignore-mode)

(require 'undo-tree);;undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'yasnippet);;定型文補完
(require 'yasnippet-bundle)
(yas/initialize)

(require 'open-junk-file);;使い捨てないscratch
(setq open-junk-file-directory "~/Documents/log/%Y/%m/%d/")

(require 'auto-save-buffers);;本当の自動保存
(run-with-idle-timer 10.0 t 'auto-save-buffers "" "")
