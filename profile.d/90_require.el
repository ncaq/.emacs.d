;;requireして2行ぐらい書くだけのものはここに全部ツッコむ
(require 'grep-edit)
(require 'lispxmp);;xmpfilterのemacs lisp version
(require 'sudden-death);突然の死
(require 'text-adjust)

(require 'server);;emacsclientのserverを立ち上げる
(unless (server-running-p)
  (server-start))

(require 'undo-tree);;undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'yasnippet);;定型文補完
(require 'yasnippet-bundle)
(yas/initialize)

(require 'linum);;行番号を左に表示
(global-linum-mode)

(require 'auto-install);;Emacswikiとかからinstallしてくる
(setq auto-install-directory "~/.emacs.d/auto-install.d/")

(require 'open-junk-file);;使い捨てないscratch
(setq open-junk-file-directory "~/Documents/log/%Y/%m/%d/")

(require 'auto-save-buffers);;本当の自動保存
(run-with-idle-timer 10.0 t 'auto-save-buffers "" "\\.el$")

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'mode-compile);;かしこいコンパイル
(defconst c++-default-compiler-options
  "-std=c++11 -Wall -Wextra -ggdb -pipe")

(require 'git-commit-mode)
(require 'gitconfig-mode)
(require 'gitignore-mode)
