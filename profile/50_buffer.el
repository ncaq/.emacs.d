;; -*- lexical-binding: t -*-

;; 等幅になるようにRictyを設定
(set-face-attribute 'default nil :family "Ricty" :height 135)
(set-fontset-font t 'unicode (font-spec :name "Ricty") nil 'append)

;; シンタックスハイライトをグローバルで有効化
(global-font-lock-mode 1)

;; テーマを読み込む
(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

;; 以下の順番で読み込まないと正常に動かなかった
;; rainbow-delimiters -> rainbow-mode

;; 括弧の対応を色対応でわかりやすく
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable)
(add-hook 'web-mode-hook 'rainbow-delimiters-mode-enable)
(set-face-foreground 'rainbow-delimiters-depth-1-face "#586e75") ;文字列の色と被るため,変更

;; 色コードを可視化
(require 'rainbow-mode)
(add-hook 'css-mode-hook        'rainbow-turn-on)
(add-hook 'emacs-lisp-mode-hook 'rainbow-turn-on)
(add-hook 'hamlet-mode-hook     'rainbow-turn-on)
(add-hook 'help-mode-hook       'rainbow-turn-on)
(add-hook 'js-mode              'rainbow-turn-on)
(add-hook 'lisp-mode-hook       'rainbow-turn-on)
(add-hook 'sass-mode-hook       'rainbow-turn-on)
(add-hook 'scss-mode-hook       'rainbow-turn-on)
(add-hook 'web-mode-hook        'rainbow-turn-on)

; カットペーストなど挿入削除時にハイライト
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; 置換の動きを可視化
(require 'anzu)
(global-anzu-mode t)
