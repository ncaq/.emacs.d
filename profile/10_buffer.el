;; -*- lexical-binding: t -*-

(set-face-attribute 'default nil :family "Ricty" :height 120)
(set-fontset-font nil 'unicode (font-spec :family "Ricty"))

(global-font-lock-mode);syntax highlight

(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

;; 順番重要
;; rainbow-delimiters -> rainbow-mode

(custom-set-faces
 '(rainbow-delimiters-mode t)
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#586e75"))))) ;文字列の色と被るため,変更

(autoload 'rainbow-turn-on "rainbow-mode")
(add-hook 'emacs-lisp-mode-hook 'rainbow-turn-on)
(add-hook 'lisp-mode-hook       'rainbow-turn-on)
(add-hook 'scss-mode-hook       'rainbow-turn-on)
(add-hook 'web-mode-hook        'rainbow-turn-on)

(require 'volatile-highlights)
(volatile-highlights-mode t)
