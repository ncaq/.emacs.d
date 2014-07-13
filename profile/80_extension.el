;; -*- lexical-binding: t -*-
(custom-set-variables
 '(auto-mode-alist
   (append
    '(
      ("\\.license\\'" . conf-mode)
      ("\\.mask\\'" . conf-mode)
      ("\\.md\\'" . markdown-mode)
      ("\\.unmask\\'" . conf-mode)
      ("\\.use\\'" . conf-mode)
      ("\\.zsh\\'" . shell-script-mode)
      ("nginx.conf" . nginx-mode)
      )
    auto-mode-alist))
 '(scheme-program-name "gosh"))
(defvar inferior-lisp-program "clisp")

(require 'nxml-mode)
(define-key nxml-mode-map (kbd "C-M-n") 'nil)
(define-key nxml-mode-map (kbd "M-h")   'nil)

(require 'make-mode)
(define-key makefile-mode-map (kbd "M-n") 'nil)
(define-key makefile-mode-map (kbd "M-t") 'nil)

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