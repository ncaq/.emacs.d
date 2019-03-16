;; -*- lexical-binding: t -*-

(custom-set-variables
 ;; Manページを現在のウィンドウで表示
 '(Man-notify-method 'bully)
 ;; 括弧移動無効
 '(blink-matching-paren nil)
 ;; ごみ箱を有効
 '(delete-by-moving-to-trash t)
 ;; diffをunifitedモードで
 '(diff-switches "-u")
 ;; 一部のコマンドを有効にする
 '(disabled-command-function nil)
 ;; ediffでウィンドウを横分割
 '(ediff-split-window-function 'split-window-horizontally)
 ;; ediffにframeを生成させない
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 ;; 自動再読込
 '(global-auto-revert-mode 1)
 ;; google翻訳のソースを英語に
 '(google-translate-default-source-language "en")
 ;; google翻訳の対象を日本語に
 '(google-translate-default-target-language "ja")
 ;; dotファイルで自動セミコロン挿入しない
 '(graphviz-dot-auto-indent-on-semi nil)
 ;; imaximaの全体を大きくする
 '(imaxima-scale-factor 10.0)
 ;; インデントをスペースで行う
 '(indent-tabs-mode nil)
 ;; 大文字と小文字を区別しない バッファ名
 '(read-buffer-completion-ignore-case t)
 ;; 大文字と小文字を区別しない ファイル名
 '(read-file-name-completion-ignore-case t)
 ;; ファイルの最後に改行
 '(require-final-newline t)
 ;; schemeの処理系はgauche
 '(scheme-program-name "gosh")
 ;; 最下段までスクロールしてもカーソルを中心に戻さない
 '(scroll-step 1)
 ;; skypeのid
 '(skype--my-user-handle "ncaq__")
 ;; 常にシンボリックリンクをたどる
 '(vc-follow-symlinks t)
 ;; インデント幅はデフォルト2
 '(tab-width 2)
 ;; 警告をエラーレベルでないと表示しない
 '(warning-minimum-level :error)
 ;; クリップボードをX11と共有
 '(x-select-enable-clipboard t)
 )

;;スクリプトに実行権限付加
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;;"yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)
