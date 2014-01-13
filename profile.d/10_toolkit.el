(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない
(setq frame-title-format (format "%%b"));タイトルバーにバッファ名を表示する

;;mode-lineに改行コードを表示
(setq eol-mnemonic-dos	"(CRLF)")
(setq eol-mnemonic-mac	"(CR)")
(setq eol-mnemonic-unix "(LF)")

;;フルパスを表示
(set-default 'mode-line-buffer-identification
	 '(buffer-file-name ("%f") ("%b")))

(require 'linum);;行番号を左に表示
(require 'auto-complete)
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
(setq uniquify-buffer-name-style 'forward)
