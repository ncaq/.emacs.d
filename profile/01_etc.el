(custom-set-variables
 '(backup-directory-alist '(("" . "~/.emacs.d/backup")))
 '(blink-matching-paren nil);括弧移動無効
 '(delete-by-moving-to-trash t);ごみ箱を有効
 '(history-length 500);ミニバッファの履歴の保存数を増やす
 '(indent-tabs-mode nil) 
 '(kept-new-versions 100000);新しいものをいくつ残すか
 '(kept-old-versions 100000);古いものをいくつ残すか
 '(make-backup-files t);バックアップファイルを作成する。
 '(message-log-max 1000);ログの記録行数を増やす.
 '(mode-require-final-newline nil)
 '(read-buffer-completion-ignore-case t);大文字と小文字を区別しない バッファ名
 '(read-file-name-completion-ignore-case t);ファイル名
 '(save-place t)
 '(trash-directory "~/trash/")
 '(version-control t);複数バックアップ
 '(x-select-enable-clipboard t));クリップボードをX11と共有

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p);スクリプトに実行権限付加
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(savehist-mode 1);ミニバッファの履歴を保存する
