;; -*- lexical-binding: t -*-
(require 'auto-async-byte-compile)
(custom-set-variables '(auto-async-byte-compile-suppress-warnings t))
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(eval-after-load 'flycheck
  '(setq flycheck-checkers
         (delq 'emacs-lisp-checkdoc flycheck-checkers)));emacs-lisp-checkdoc,設定ファイルごときにそんなに気合入れなくて良いです
(custom-set-variables '(flycheck-emacs-lisp-load-path load-path))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(define-key emacs-lisp-mode-map (kbd "C-c e") 'eval-buffer)
(define-key read-expression-map (kbd "<tab>") 'lisp-complete-symbol);M-S-;