;;http://skalldan.wordpress.com/2012/05/11/emacs-ibus-mozc-で日本語入力/
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)

(ibus-disable-isearch);isearch 時はオフに
(add-hook 'minibuffer-setup-hook 'ibus-disable);mini buffer ではオフに

(setq ibus-cursor-color '("red"));IBusの状態によってカーソル色を変化させる ("on" "off" "disabled")

;;(setq ibus-mode-local nil);すべてのバッファで入力状態を共有 (default ではバッファ毎にインプットメソッドの状態を保持)
(setq ibus-prediction-window-position t);カーソル位置で予測候補ウィンドウを表示 (default はプリエディット領域の先頭位置に表示);;プリエディット領域 is 何
(setq ibus-isearch-cursor-type 'hollow);インクリメンタル検索中のカーソル形状を変更する
(setq ibus-undo-by-committed-string t);アンドゥの時に、文字列を確定した位置ごとに戻るようにする

;;Key
(ibus-define-common-key (kbd "C-SPC") nil);C-SPC は Set Mark に使う
(ibus-define-common-key (kbd "C-/") nil);C-/ は Undo に使う
(global-set-key [zenkaku-hankaku] 'ibus-toggle)
(global-set-key [henkan] 'ibus-enable);Use henkan key to enable IBus
(global-set-key [muhenkan] 'ibus-disable);Use muhenkan key to disable IBus
;;Enable muhenkan key only for preediting
(ibus-define-common-key 'muhenkan nil)
(ibus-define-preedit-key 'muhenkan t)
