;; -*- lexical-binding: t -*-

(custom-set-variables
 '(auto-async-byte-compile-suppress-warnings t)
 ;; emacs-lisp-checkdocは設定ファイルには不向き
 '(flycheck-disabled-checkers (append '(emacs-lisp-checkdoc) flycheck-disabled-checkers))
 '(flycheck-emacs-lisp-load-path load-path)
 )

(define-key emacs-lisp-mode-map (kbd "C-M-q") 'nil)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(autoload 'enable-auto-async-byte-compile-mode "auto-async-byte-compile")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'help-mode-hook 'elisp-slime-nav-mode)

(with-eval-after-load 'elisp-slime-nav
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d")
    'elisp-slime-nav-describe-elisp-thing-at-point))

(define-key read-expression-map (kbd "<tab>") 'completion-at-point)
