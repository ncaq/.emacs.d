;;スクリプトに実行権限付加
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; 最終行に必ず一行挿入する
(setq require-final-newline t)

;;emacs lispを保存する時に自動バイトコンパイル
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/emacsAutoAsyncJunk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'saveplace);;カーソル位置記憶
(setq-default save-place t)

(require 'undohist);;undoをファイル閉じても保存
(setq undohist-directory "~/.undohist/")
(undohist-initialize)

(add-hook 'kill-emacs-hook '(lambda ()
			      (shell-command "rm .\#.recentf")))
