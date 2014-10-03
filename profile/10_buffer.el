;; -*- lexical-binding: t -*-

(set-face-attribute 'default nil :family "Ricty" :height 160)
(set-fontset-font nil 'unicode (font-spec :family "Ricty"))

(global-font-lock-mode);syntax highlight

(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

;; 順番重要
;; rainbow-delimiters -> rainbow-mode

(eval-after-load 'rainbow-delimiters
  '(progn
     (add-to-list 'rainbow-delimiters-ignore-modes 'fundamental-mode)                    ;helmとの干渉回避
     ))
(custom-set-faces '(rainbow-delimiters-depth-1-face ((t (:foreground "#586e75"))))) ;文字列の色と被るため,変更
(global-rainbow-delimiters-mode 1)

(add-hook 'emacs-lisp-mode-hook 'rainbow-turn-on)
(add-hook 'lisp-mode-hook       'rainbow-turn-on)
(add-hook 'scss-mode-hook       'rainbow-turn-on)
(add-hook 'web-mode-hook        'rainbow-turn-on)

(require 'volatile-highlights)
(volatile-highlights-mode t)

;;package-listのformat
(define-derived-mode package-menu-mode tabulated-list-mode "Package Menu"
  "Major mode for browsing a list of packages.
Letters do not insert themselves; instead, they are commands.
\\<package-menu-mode-map>
\\{package-menu-mode-map}"
  (setq tabulated-list-format [("Package" 35 package-menu--name-predicate)
                               ("Version" 15 package-menu--version-predicate)
                               ("Status"  10 package-menu--status-predicate)
                               ("Description" 10 package-menu--description-predicate)])
  (setq tabulated-list-padding 1)
  (setq tabulated-list-sort-key (cons "Status" nil))
  (tabulated-list-init-header))

(eval-after-load 'ibuffer
  '(progn
     (custom-set-variables '(ibuffer-formats
                             '((mark modified read-only " " (name 60 30)
                                     " " (size 6 -1) " " (mode 16 16) " " filename)
                               (mark " " (name 60 -1) " " filename))))
     (define-key ibuffer-mode-map (kbd "C-o") 'nil)
     (define-key ibuffer-mode-map (kbd "C-t") 'nil)
     ))
