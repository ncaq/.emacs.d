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
(setq auto-install-directory "~/.emacs.d/install/")

(require 'recentf-ext);;recentfのディレクトリも表示する改造版
(setq recentf-max-menu-items 10000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

(require 'open-junk-file);;使い捨てないscratch
(setq open-junk-file-directory "~/Documents/log/%Y/%m/%d/%H_%M_%S.")

(require 'auto-save-buffers);;本当の自動保存
(run-with-idle-timer 10.0 t 'auto-save-buffers "" "\\.el$")

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'mode-compile);;かしこいコンパイル
(defconst c++-default-compiler-options
  "-std=c++11 -Wall -Wextra -ggdb -pipe")
