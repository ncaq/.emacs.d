;;描画関係
(auto-image-file-mode);画像表示
(defvar hl-line-face)
(global-font-lock-mode t);モードに合わせるらしい?
(global-hl-line-mode);現在行を目立たせる
(menu-bar-mode 0);menu bar を表示させない
(set-frame-font "Ricty:pixelsize=16");フォント設定
(setq frame-title-format "%f %Z %m %s");title bar にファイル名,その他を表示
(setq hl-line-face 'underline);↑下線で
(show-paren-mode t);対応する括弧をハイライト
(tool-bar-mode 0);tool bar を表示させない
(which-function-mode 1);ウィンドウの上部に現在の関数名を表示します。
