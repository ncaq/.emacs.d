;; -*- lexical-binding: t -*-

(autoload 'sdic "sdic")
(autoload 'sudden-death "sudden-death")

(autoload 'open-junk-file "open-junk-file")
(custom-set-variables '(open-junk-file-format "~/Documents/log/%Y_%m/"))

(require 'auto-sudoedit-autoloads)
(require 'ncaq-emacs-utils)
(require 'symbolword-mode)
(require 'w3m-goto-alc-autoloads)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(eval-after-load 'mozc
  '(progn
     (custom-set-variables
      '(default-input-method 'japanese-mozc)
      '(mozc-candidate-style 'echo-area)
      )
     (define-key mozc-mode-map (kbd "C-;") 'toggle-input-method)
     ))

(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))

(eval-after-load 'skype
  '(progn
     (setq skype--my-user-handle "ncaq__")
     ))

(eval-after-load 'gud
  '(progn
     (custom-set-variables '(gud-tooltip-echo-area t));t にすると mini buffer に値が表示される
     (define-key gud-mode-map (kbd "<f10>") 'gud-finish);step out 現在のスタックフレームを抜ける
     (define-key gud-mode-map (kbd "<f11>") 'gud-cont);ブレークポイントに会うまで実行
     (define-key gud-mode-map (kbd "C-M-b") 'gud-break);ブレークポイント設置
     (define-key gud-mode-map (kbd "C-M-n") 'gud-step);1行進む.関数に入る
     (define-key gud-mode-map (kbd "C-M-r") 'gud-remove);ブレークポイント削除
     (define-key gud-mode-map (kbd "C-M-s") 'gud-next);1行進む
     (define-key gud-mode-map (kbd "C-M-u") 'gud-until);現在の行まで実行
     ))
