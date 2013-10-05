;;emacs lispを保存する時に自動バイトコンパイル
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/emacsAutoAsyncJunk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(autoload 'lispxmp "lispxmp");;xmpfilterのemacs lisp version

(define-key emacs-lisp-mode-map	(kbd "C-M-q")	'kill-buffer);なんか予め設定されてるから
(define-key emacs-lisp-mode-map	(kbd "C-c e")	'eval-buffer);C-cC-eでeval-bufferを実行
(define-key read-expression-map (kbd "<tab>")	'lisp-complete-symbol);M-S-;
