(require 'pos-tip)
(require 'popup)
(require 'fuzzy)
;;http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete-config)
(require 'auto-complete)
(ac-config-default)
(global-auto-complete-mode t)

(ac-set-trigger-key "TAB")
(define-key ac-completing-map	(kbd "C-n") 'ac-next)
(define-key ac-completing-map	(kbd "C-p") 'ac-previous)
(define-key ac-mode-map		(kbd "C-'") 'auto-complete)
(define-key ac-mode-map		(kbd "M-'") 'ac-fuzzy-complete)
(setq ac-auto-start nil);;自動で補完画面を出すならt.補完キーを押すまで補完画面を出さないならnil.数字なら文字数.
(setq popup-use-optimized-column-computation nil);;最適化の有無,最適化すると時折崩れる
(setq ac-menu-height 22);;補完列表示数
(setq ac-use-quick-help t);ヘルプを表示
(setq ac-quick-help-delay 1);;ヘルプを即表示,pos-tipを使えば崩れ無くなった
(setq ac-ignore-case t);;大文字・小文字を区別
;;(setq ac-stop-flymake-on-completing t);補完時flymake遅延
;;(setq ac-use-fuzzy t);;曖昧補完

;;ファイル名補完どうして初期は無効なんですかね…
;;全てのバッファで`ac-sources`の先頭にファイル名辞書情報源を追加する
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-filename))

;;auto-completeが有効にならないモードで有効に,というか全てのモードで有効にして欲しい…
(add-to-list 'ac-modes 'conf-mode)
(add-to-list 'ac-modes 'd-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'shell-script-mode)
(add-to-list 'ac-modes 'text-mode)
