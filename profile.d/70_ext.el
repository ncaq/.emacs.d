(add-to-list 'auto-mode-alist '("\\.license\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.unmask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("nginx.conf" . nginx-mode))

(require 'inf-lisp)
(setq inferior-lisp-program "clisp")

(require 'scheme)
(setq scheme-program-name "gosh")

(require 'hexl)
(define-key hexl-mode-map (kbd "C-q") nil)

(require 'nxml-mode)
(define-key nxml-mode-map (kbd "M-h") nil)

(require 'make-mode)
(define-key makefile-mode-map (kbd "M-p") nil)
(define-key makefile-mode-map (kbd "M-t") nil)
