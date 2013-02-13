;;ファイルを作るまでも無い設定をここに書く
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode));*.dはd言語
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode));*.mdをmarkdownに設定
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode));zshのシェルスクリプトに対応
(auto-image-file-mode);画像表示
(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t);Markdown
(desktop-save-mode 1);;起動時に,前回終了していた時に開いていたバッファを一度開いたり,色々復元する
(ffap-bindings);C-x C-fでカーソルの位置にあるファイルパスとURLを入力
(fset 'yes-or-no-p 'y-or-n-p);"yes or no"を"y or n"に
(global-font-lock-mode t);モードに合わせるらしい?
(global-hl-line-mode);現在行を目立たせる
(global-set-key "\C-m" 'newline-and-indent);;改行時にインデント
(kill-buffer "*scratch*");open-junk-fileがあるからscratchいらないです^^;
(menu-bar-mode 0);menu bar を表示させない
(set-frame-font "Ricty:pixelsize=14:spacing=0");フォント設定
(setq delete-by-moving-to-trash t);ごみ箱を有効
(setq dired-listing-switches "-AFlhv");;diredでソート順を設定
(setq frame-title-format "%f %Z %m %s");title bar にファイル名,その他を表示
(setq kill-whole-line t);C-kで行全体を削除
(setq next-line-add-newlines t);c-nした時に行を追加
(setq windmove-wrap-around t);Window移動をループする
(setq x-select-enable-clipboard t);クリップボード共有
(setq-default indent-tabs-mode t);;インデントをタブでする
(show-paren-mode t);対応する括弧をハイライト
(tool-bar-mode 0);tool bar を表示させない
(which-function-mode 1);ウィンドウの上部に現在の関数名を表示します。
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

;;ブラウザをOperaに
;;http://d.hatena.ne.jp/portown/20100531/1297222343
(setq browse-url-firefox-program "opera")
(setq browse-url-firefox-new-window-is-tab t)
(setq browse-url-new-window-flag t)
