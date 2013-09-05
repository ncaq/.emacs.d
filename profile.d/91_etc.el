;;ファイルを作るまでも無い設定をここに書く
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t);Markdown
(add-to-list 'auto-mode-alist '("\\.X.*" . conf-xdefaults-mode));xの設定ファイル
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode));markdownの拡張子は.mdを採用
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode));zshのシェルスクリプトに対応

(defvar windmove-wrap-around)

(add-hook 'pre-command-hook (abbrev-mode nil));auto-complete.el使うからいらない
(desktop-save-mode 1);起動時に,前回終了していた時に開いていたバッファを一度開いたり,色々復元する
(display-time);時刻表示
(ffap-bindings);C-x C-fでカーソルの位置にあるファイルパスとURLを入力
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(global-subword-mode 1);CamelCaseの語でも単語単位に分解して編集する
(savehist-mode 1);ミニバッファの履歴を保存する
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq dired-listing-switches "-hFAvilaD");diredでソート順を設定
(setq history-length 10000);ミニバッファの履歴の保存数を増やす
(setq message-log-max 10000);ログの記録行数を増やす.
(setq next-line-add-newlines t);c-nした時に行を追加
(setq read-buffer-completion-ignore-case t)    ;;大文字と小文字を区別しない バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名
(setq user-mail-address "nyrigadake38@gmail.com")
(setq windmove-wrap-around t);Window移動をループする
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default indent-tabs-mode t);インデントをタブでする

(kill-buffer "*scratch*");open-junk-fileがあるからscratchいらないです^^;
(kill-buffer "*Shell Command Output*")
