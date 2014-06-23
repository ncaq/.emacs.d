;; -*- lexical-binding: t -*-
(add-to-list 'auto-mode-alist '("\\.license\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.unmask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("nginx.conf" . nginx-mode))

(custom-set-variables '(scheme-program-name "gosh"))

(defvar inferior-lisp-program "clisp")

(defvar ac-sources)
(add-hook 'latex-mode-hook (lambda () (setq ac-sources (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands) ac-sources))))

(require 'nxml-mode)
(define-key nxml-mode-map (kbd "C-M-n") nil)
(define-key nxml-mode-map (kbd "M-h") nil)

(require 'make-mode)
(define-key makefile-mode-map (kbd "M-n") nil)
(define-key makefile-mode-map (kbd "M-t") nil)

(require 'hexl)
(define-key hexl-mode-map (kbd "C-h")   'hexl-backward-char)
(define-key hexl-mode-map (kbd "C-s")   'hexl-forward-char)
(define-key hexl-mode-map (kbd "C-t")   'hexl-previous-line)
(define-key hexl-mode-map (kbd "M-h")   'hexl-backward-word)
(define-key hexl-mode-map (kbd "M-s")   'hexl-forward-word)

(define-key hexl-mode-map (kbd "C-M-t") 'nil)
(define-key hexl-mode-map (kbd "C-f")   'nil)
(define-key hexl-mode-map (kbd "C-q")   'nil)
(define-key hexl-mode-map (kbd "M-f")   'nil)