;;ファイルを作るまでも無い設定をここに書く
(defvar windmove-wrap-around)
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動
(setq windmove-wrap-around t);Window移動をループする

(desktop-save-mode t);起動時に,前回終了していた時に開いていたバッファを一度開いたり,色々復元する
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(global-subword-mode t);CamelCaseの語でも単語単位に分解して編集する
(savehist-mode t);ミニバッファの履歴を保存する

(setq next-line-add-newlines t);c-nした時に行を追加
(setq user-mail-address "nyrigadake38@gmail.com")
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default indent-tabs-mode t);インデントをタブでする
