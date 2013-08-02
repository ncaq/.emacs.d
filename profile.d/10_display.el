;;描画関係
(global-font-lock-mode t);モードに合わせるらしい?
(set-frame-font "Ricty:pixelsize=16");フォント設定

(setq frame-title-format "%f %Z %m %s");title bar にファイル名,その他を表示
(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない
(which-function-mode 1);ウィンドウの下部に現在の関数名を表示します。

(defvar hl-line-face)
(global-hl-line-mode);現在行を目立たせる
(setq hl-line-face 'underline);↑下線で
(show-paren-mode t);対応する括弧をハイライト
(auto-image-file-mode);画像表示

(require 'linum);;行番号を左に表示
(global-linum-mode)
;;auto-complete時に崩れる問題を修正
(defadvice linum-update
  (around tung/suppress-linum-update-when-popup activate)
  (unless (ac-menu-live-p)
    ad-do-it))

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
