(add-to-list 'auto-mode-alist '("\\.license\\'" . conf-mode));portage
(add-to-list 'auto-mode-alist '("\\.mask\\'" . conf-mode));portage
(add-to-list 'auto-mode-alist '("\\.unmask\\'" . conf-mode));portage
(add-to-list 'auto-mode-alist '("\\.use\\'" . conf-mode));portage
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode));zshのシェルスクリプトに対応

(require 'inf-lisp)
(setq inferior-lisp-program "clisp")

(require 'scheme)
(setq scheme-program-name "gosh")

(require 'hexl)
(define-key hexl-mode-map (kbd "C-q") nil)

(require 'nxml-mode)
(define-key nxml-mode-map (kbd "M-h") nil)
