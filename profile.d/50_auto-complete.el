(require 'pos-tip)
(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete/lib/popup-el/")
(require 'popup)
(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete/lib/fuzzy-el/")
(require 'fuzzy)

;;http://cx4a.org/software/auto-complete/manual.ja.html
(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete/")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/bigprogram.d/auto-complete/ac-dict/")

(setq ac-auto-start 5);;自動で補完画面を出すならt.補完キーを押すまで補完画面を出さないならnil.数字なら文字数.
(setq popup-use-optimized-column-computation nil);;なんか時々崩れるので最適化しないように
(setq ac-menu-height 22);;22行表示
(setq ac-use-quick-help t);ヘルプを表示する
(setq ac-quick-help-delay 0);;ヘルプを即表示…する,pos-tipを使えば崩れ無くなった
(setq ac-ignore-case t);;大文字・小文字を区別しない
(setq ac-use-fuzzy t);;曖昧補完する

;;補完キー指定
(ac-set-trigger-key "TAB")
(define-key ac-mode-map (kbd "C-'") 'auto-complete)
(setq ac-use-menu-map t)

;;ファイル名補完どうして初期は無効なんですかね…
;; 全てのバッファで`ac-sources`の先頭にファイル名辞書情報源を追加する
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-filename))


