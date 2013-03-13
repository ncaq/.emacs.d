;;requireして2行ぐらい書くだけのものはここに全部ツッコむ

(require 'disk);ファイルを保存する時に,外部から更新されてたら警告を出して保存しないコマンド.それ以外はただのsave-buffer
(require 'sudden-death);突然の死

;;emacs lispを保存する時に自動バイトコンパイル
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/emacsAutoAsyncJunk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;emacsclientのserverを立ち上げる
(require 'server)
(unless (server-running-p)
  (server-start))

;;undoをtreeに,C-x C-uで起動
(require 'undo-tree)
(global-undo-tree-mode)

;;http://blog.clouder.jp/archives/001037.html
;;プログラミング言語の定型文補完
(require 'yasnippet)
(require 'yasnippet-bundle)
(yas/initialize)

;;undoをファイル閉じても保存
(require 'undohist)
(setq undohist-directory "~/.undohist/")
(undohist-initialize)

;;行番号を左に表示
;;http://www23.atwiki.jp/selflearn/pages/41.html#id_51d1d876
(require 'linum)
(global-linum-mode)

;;Emacswikiとかからinstallしてくる
(require 'auto-install)
;;http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(setq auto-install-directory "~/.emacs.d/install/")

;;recentfのディレクトリも表示する改造版
(require 'recentf-ext)
(setq recentf-max-menu-items 10000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

;;xmpfilterのemacs lisp version
(require 'lispxmp)

;;使い捨てないscratch
(require 'open-junk-file)
(setq open-junk-file-directory "~/documents/log/%Y/%m/%d/%H_%M_%S.")

;;本当の自動保存
(require 'auto-save-buffers)
(run-with-idle-timer 15.0 t 'auto-save-buffers)

(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t);Markdown
