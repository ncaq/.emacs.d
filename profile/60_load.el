;; -*- lexical-binding: t -*-
(autoload 'sdic "sdic")
(autoload 'sudden-death "sudden-death")
(autoload 'text-adjust-selective "text-adjust")

(autoload 'open-junk-file "open-junk-file")
(custom-set-variables '(open-junk-file-format "~/Documents/log/%Y_%m/"))

(require 'ncaq-emacs-utils)
(require 'root-tramp)
(require 'symbolword-mode)

(require 'recentf)
(custom-set-variables
 '(recentf-save-file "~/.emacs.d/recentf")
 '(recentf-max-saved-items 1000)
 '(recentf-exclude '("~$" "\\.elc$" "TAGS" "\\.backup" "\\.undohist" "trash")))
(recentf-mode 1)
(require 'recentf-ext)
(require 'recentf-purge-tramp)

(require 'mozc)
(setq default-input-method 'japanese-mozc)
(setq mozc-candidate-style 'echo-area)
(global-set-key (kbd "C-;") 'toggle-input-method)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'desktop)
(add-hook 'after-init-hook 'desktop-save-mode)

(require 'windmove)
(setq windmove-wrap-around t);Window移動をループする
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

(require 'zlc-autoloads)
(zlc-mode 1)

(require 'git-gutter-fringe)
(global-git-gutter-mode)

(require 'skype)
(setq skype--my-user-handle "ncaq__")

(require 'google-translate)
(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c n") 'google-translate-at-point-reverse)

(require 'gud)
(custom-set-variables '(gud-tooltip-echo-area t));t にすると mini buffer に値が表示される
(define-key gud-mode-map (kbd "<f10>") 'gud-finish);step out 現在のスタックフレームを抜ける
(define-key gud-mode-map (kbd "<f11>") 'gud-cont);ブレークポイントに会うまで実行
(define-key gud-mode-map (kbd "C-M-b") 'gud-break);ブレークポイント設置
(define-key gud-mode-map (kbd "C-M-n") 'gud-step);1行進む.関数に入る
(define-key gud-mode-map (kbd "C-M-r") 'gud-remove);ブレークポイント削除
(define-key gud-mode-map (kbd "C-M-s") 'gud-next);1行進む
(define-key gud-mode-map (kbd "C-M-u") 'gud-until);現在の行まで実行
 