;; -*- lexical-binding: t -*-

(set-face-attribute 'default nil :family "Ricty" :height 120)
(set-fontset-font nil 'unicode (font-spec :family "Ricty"))

(global-font-lock-mode);syntax highlight

(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

;; 順番重要
;; rainbow-delimiters -> rainbow-mode

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable)
(set-face-foreground 'rainbow-delimiters-depth-1-face "#586e75") ;文字列の色と被るため,変更

(autoload 'rainbow-turn-on "rainbow-mode")
(add-hook 'css-mode-hook        'rainbow-turn-on)
(add-hook 'emacs-lisp-mode-hook 'rainbow-turn-on)
(add-hook 'help-mode-hook       'rainbow-turn-on)
(add-hook 'lisp-mode-hook       'rainbow-turn-on)
(add-hook 'scss-mode-hook       'rainbow-turn-on)
(add-hook 'web-mode-hook        'rainbow-turn-on)

(require 'volatile-highlights)
(volatile-highlights-mode t)
