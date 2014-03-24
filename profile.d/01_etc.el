(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p);スクリプトに実行権限付加
(auto-image-file-mode);画像表示
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(savehist-mode);ミニバッファの履歴を保存する
(set-frame-parameter nil 'fullscreen 'maximized);gtk maxium

(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
(setq blink-matching-paren nil);括弧移動無効
(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq history-length 5000);ミニバッファの履歴の保存数を増やす
(setq kept-new-versions 100000);新しいものをいくつ残すか
(setq kept-old-versions 100000);古いものをいくつ残すか
(setq make-backup-files t);バックアップファイルを作成する。
(setq message-log-max 5000);ログの記録行数を増やす.
(setq read-buffer-completion-ignore-case t);大文字と小文字を区別しない バッファ名
(setq read-file-name-completion-ignore-case t);ファイル名
(setq require-final-newline t);最終行に必ず一行挿入する
(setq user-mail-address "ncaq@mail.ncaq.net")
(setq version-control t);複数のバックアップを残します。世代。
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default save-place t)
