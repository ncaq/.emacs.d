;;ファイルを作るまでも無い設定をここに書く
(require 'windmove)
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動
(setq windmove-wrap-around t);Window移動をループする

(auto-image-file-mode);画像表示
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(savehist-mode t);ミニバッファの履歴を保存する

(setq blink-matching-paren nil);括弧移動無効
(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq history-length 5000);ミニバッファの履歴の保存数を増やす
(setq message-log-max 5000);ログの記録行数を増やす.
(setq next-line-add-newlines t);c-nした時に行を追加
(setq read-buffer-completion-ignore-case t)    ;;大文字と小文字を区別しない バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名
(setq user-mail-address "nyrigadake38@gmail.com")
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default indent-tabs-mode t);インデントをタブでする
