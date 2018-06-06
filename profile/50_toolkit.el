;; -*- lexical-binding: t -*-
(menu-bar-mode 0)                       ; menu bar を表示させない
(tool-bar-mode 0)                       ; tool bar を表示させない
(toggle-frame-maximized)                ; 全画面化

(auto-image-file-mode 1);画像表示

;; ((ファイル名 or バッファ名) モード一覧)
(setq frame-title-format
      '(:eval (list (or (buffer-file-name) (buffer-name)) " " mode-line-modes)))

;; mode-line line and column and sum char numbar
(setq mode-line-position
      '(:eval
        (list
         "l%l/"
         (number-to-string (count-lines (point-min) (point-max)))
         " c"
         (number-to-string (- (point) (line-beginning-position)))
         "/"
         (number-to-string (- (line-end-position) (line-beginning-position)))
         " s"
         (number-to-string (point))
         "/%i"
         )))

(custom-set-variables '(global-display-line-numbers-mode 1)) ; 行番号を左に表示

(require 'uniquify)
(custom-set-variables '(uniquify-buffer-name-style 'forward))

(global-anzu-mode t)
