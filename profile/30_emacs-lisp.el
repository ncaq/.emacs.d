;; -*- lexical-binding: t -*-

(require 'auto-async-byte-compile)
(custom-set-variables '(auto-async-byte-compile-suppress-warnings t))
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(with-eval-after-load 'elisp-slime-nav
  (define-key elisp-slime-nav-mode-map (kbd "C-.") 'elisp-slime-nav-find-elisp-thing-at-point)
  (define-key elisp-slime-nav-mode-map (kbd "M-.") 'pop-tag-mark)
  (define-key elisp-slime-nav-mode-map (kbd "M-,") 'nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d") 'elisp-slime-nav-describe-elisp-thing-at-point)
  )
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'help-mode-hook 'elisp-slime-nav-mode)

(with-eval-after-load 'flycheck
  (custom-set-variables
   '(flycheck-disabled-checkers (append '(emacs-lisp-checkdoc) flycheck-disabled-checkers)) ;emacs-lisp-checkdocは設定ファイルには不向き
   '(flycheck-emacs-lisp-load-path load-path)
   ))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(define-key emacs-lisp-mode-map (kbd "C-M-q") 'nil)
(define-key emacs-lisp-mode-map (kbd "C-c e") 'eval-buffer)
