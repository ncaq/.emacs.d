(require 'auto-async-byte-compile);emacs lispを保存する時に自動バイトコンパイル
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/emacsAutoAsyncJunk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'flycheck)
(eval-after-load
    'flycheck '(setq flycheck-checkers
		     (delq 'emacs-lisp-checkdoc flycheck-checkers)));emacs-lisp-checkdoc,設定ファイルごときにそんなに気合入れなくて良いです
(defun ncaq-emacs-lisp ()
  (setq flycheck-emacs-lisp-load-path load-path))
(add-hook 'emacs-lisp-mode-hook 'ncaq-emacs-lisp)

(require 'eldoc)
(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-echo-area-use-multiline-p)

(define-key emacs-lisp-mode-map	(kbd "C-c e")	'eval-buffer);C-cC-eでeval-bufferを実行
(define-key read-expression-map (kbd "<tab>")	'lisp-complete-symbol);M-S-;
