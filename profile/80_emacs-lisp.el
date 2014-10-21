;; -*- lexical-binding: t -*-

(require 'auto-async-byte-compile)
(custom-set-variables '(auto-async-byte-compile-suppress-warnings t))
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(eval-after-load 'elisp-slime-nav
  '(progn
     (define-key elisp-slime-nav-mode-map (kbd "C-.") 'elisp-slime-nav-find-elisp-thing-at-point)
     (define-key elisp-slime-nav-mode-map (kbd "M-.") 'pop-tag-mark)
     (define-key elisp-slime-nav-mode-map (kbd "C-c C-d") 'elisp-slime-nav-describe-elisp-thing-at-point)
     ))
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'help-mode-hook 'elisp-slime-nav-mode)

(eval-after-load 'flycheck
  '(progn
     (custom-set-variables
      '(flycheck-emacs-lisp-load-path load-path)
      '(flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)) ;emacs-lisp-checkdocは設定ファイルには不向き)
      )
     ))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(define-key emacs-lisp-mode-map (kbd "C-c e") 'eval-buffer)
(define-key read-expression-map (kbd "<tab>") 'lisp-complete-symbol);M-S-;