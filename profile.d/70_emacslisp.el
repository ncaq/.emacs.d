(require 'auto-async-byte-compile);emacs lispを保存する時に自動バイトコンパイル
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/emacsAutoAsyncJunk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(autoload 'lispxmp "lispxmp");xmpfilterのemacs lisp version

(eval-after-load
    'flycheck '(setq flycheck-checkers
		     (delq 'emacs-lisp-checkdoc flycheck-checkers)));emacs-lisp-checkdoc,設定ファイルごときにそんなに気合入れなくて良いです

(define-key emacs-lisp-mode-map	(kbd "C-c e")	'eval-buffer);C-cC-eでeval-bufferを実行
(define-key read-expression-map (kbd "<tab>")	'lisp-complete-symbol);M-S-;
