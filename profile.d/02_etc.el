;;ファイルを作るまでも無い設定をここに書く
(defvar windmove-wrap-around)
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動
(setq windmove-wrap-around t);Window移動をループする

(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(savehist-mode t);ミニバッファの履歴を保存する

(setq next-line-add-newlines t);c-nした時に行を追加
(setq user-mail-address "nyrigadake38@gmail.com")
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default indent-tabs-mode t);インデントをタブでする
