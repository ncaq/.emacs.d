(add-to-list 'auto-mode-alist '("\\.X.*" . conf-xdefaults-mode));xの設定ファイル
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode));zshのシェルスクリプトに対応
(add-to-list 'auto-mode-alist '("\\.use\\'" . conf-mode));portage

(require 'auto-save-buffers);;本当の自動保存
(run-with-idle-timer 30 t 'auto-save-buffers)

(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq history-length 5000);ミニバッファの履歴の保存数を増やす
(setq message-log-max 5000);ログの記録行数を増やす.
(setq read-buffer-completion-ignore-case t)    ;;大文字と小文字を区別しない バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名
