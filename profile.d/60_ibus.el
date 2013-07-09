;;http://skalldan.wordpress.com/2012/05/11/emacs-ibus-mozc-で日本語入力/
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)

;;isearchの時に無効になるから解除
;;(add-hook 'minibuffer-setup-hook 'ibus-disable);mini buffer ではオフに
(ibus-disable-isearch);isearch 時はオフに
(setq ibus-cursor-color '("#dc322f" "#eee8d5" "#859900"));IBusの状態によってカーソル色を変化させる ("on" "off" "disabled")
(setq ibus-isearch-cursor-type 'hollow);インクリメンタル検索中のカーソル形状を変更する
(setq ibus-prediction-window-position t);カーソル位置で予測候補ウィンドウを表示 (default はプリエディット領域の先頭位置に表示);;プリエディット領域 is 何
(setq ibus-undo-by-committed-string t);アンドゥの時に、文字列を確定した位置ごとに戻るようにする
;;(setq ibus-mode-local nil);すべてのバッファで入力状態を共有 (default ではバッファ毎にインプットメソッドの状態を保持)

;;Key
(global-unset-key (kbd "C-\\"))
(ibus-define-common-key (kbd "C-/") nil);C-/ は Undo に使う
(ibus-define-common-key (kbd "C-SPC") nil);C-SPC は Set Mark に使う

(global-set-key (kbd "s-SPC") 'ibus-toggle)
(define-key isearch-mode-map (kbd "s-SPC") 'ibus-toggle);効くのかなあ…?
