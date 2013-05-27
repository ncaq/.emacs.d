;;ファイルを作るまでも無い設定をここに書く
(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t);Markdown
(add-to-list 'auto-mode-alist '("\\.X.*" . conf-xdefaults-mode));xの設定ファイル
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode));markdownの拡張子は.mdを採用
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode));zshのシェルスクリプトに対応
(defvar windmove-wrap-around)
(desktop-save-mode 1);起動時に,前回終了していた時に開いていたバッファを一度開いたり,色々復元する
(ffap-bindings);C-x C-fでカーソルの位置にあるファイルパスとURLを入力
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(kill-buffer "*Compile-Log*");謎
(kill-buffer "*scratch*");open-junk-fileがあるからscratchいらないです^^;
(savehist-mode 1);ミニバッファの履歴を保存する
(subword-mode t);CamelCaseの語でも単語単位に分解して編集する
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動
(display-time);時刻表示
(add-hook 'pre-command-hook (abbrev-mode nil));auto-complete.el使うからいらない

(setq history-length 1000);履歴の保存件数を増やす 履歴ってなんだ
(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq dired-listing-switches "-AFlhv");diredでソート順を設定
(setq history-length 10000);ミニバッファの履歴の保存数を増やす
(setq message-log-max 10000);ログの記録行数を増やす.
(setq next-line-add-newlines t);c-nした時に行を追加
(setq user-mail-address "nyrigadake38@gmail.com")
(setq windmove-wrap-around t);Window移動をループする
(setq x-select-enable-clipboard t);クリップボードをX11と共有
(setq-default indent-tabs-mode t);インデントをタブでする
