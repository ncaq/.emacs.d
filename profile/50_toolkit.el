;; -*- lexical-binding: t -*-
(menu-bar-mode 0)                       ; メニューバーを表示させない
(tool-bar-mode 0)                       ; ツールバーを表示させない
(toggle-frame-maximized)                ; 全画面化

(auto-image-file-mode 1)                ;画像を表示

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

(require 'uniquify)
;; バッファの名前にディレクトリ名を付けることでユニークになりやすくする
(custom-set-variables '(uniquify-buffer-name-style 'forward))
