(add-to-list 'auto-mode-alist '("\\.license\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.unmask\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("nginx.conf" . nginx-mode))

(defvar inferior-lisp-program "clisp")

(require 'scheme)
(defvar scheme-program-name "gosh")

(require 'hexl)
(define-key hexl-mode-map (kbd "C-q") nil)

(require 'nxml-mode)
(define-key nxml-mode-map (kbd "M-h") nil)

(require 'make-mode)
(define-key makefile-mode-map (kbd "M-n") nil)
(define-key makefile-mode-map (kbd "M-t") nil)

(require 'auto-complete)
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)
(add-hook 'latex-mode-hook (lambda () (setq ac-sources (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands) ac-sources))))
