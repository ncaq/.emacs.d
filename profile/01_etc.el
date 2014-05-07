(custom-set-variables
 '(mode-require-final-newline nil)
 '(backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
 '(blink-matching-paren nil);括弧移動無効
 '(delete-by-moving-to-trash t);ごみ箱を有効
 '(history-length 5000);ミニバッファの履歴の保存数を増やす
 '(kept-new-versions 100000);新しいものをいくつ残すか
 '(kept-old-versions 100000);古いものをいくつ残すか
 '(make-backup-files t);バックアップファイルを作成する。
 '(message-log-max 5000);ログの記録行数を増やす.
 '(read-buffer-completion-ignore-case t);大文字と小文字を区別しない バッファ名
 '(read-file-name-completion-ignore-case t);ファイル名
 '(version-control t);複数のバックアップを残します。世代。
 '(x-select-enable-clipboard t);クリップボードをX11と共有
 '(indent-tabs-mode nil) 
 '(save-place t))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p);スクリプトに実行権限付加
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(savehist-mode 1);ミニバッファの履歴を保存する
