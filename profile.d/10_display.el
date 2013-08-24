;;描画関係
(setq frame-title-format "%f %Z %m %s");title bar にファイル名,その他を表示
(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない

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
;;軽くする
;;http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
