;;閉じる,保存するときに色々するもの
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
	(let ((name (buffer-file-name)))
	  (or (equal ?. (string-to-char (file-name-nondirectory name)))
	      (let ((mode (file-modes name)))
		(set-file-modes name (logior mode (logand (/ mode 4) 73)))
		(message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)

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
