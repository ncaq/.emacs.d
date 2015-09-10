;; -*- lexical-binding: t -*-

(custom-set-variables
 '(blink-matching-paren nil)                ;括弧移動無効
 '(delete-by-moving-to-trash t)             ;ごみ箱を有効
 '(diff-switches "-u")                      ;diffをunifitedモードで
 '(disabled-command-function nil)
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(graphviz-dot-auto-indent-on-semi nil)
 '(indent-tabs-mode nil)                    ;インデントをスペースで行う
 '(read-buffer-completion-ignore-case t)    ;大文字と小文字を区別しない バッファ名
 '(read-file-name-completion-ignore-case t) ;大文字と小文字を区別しない ファイル名
 '(require-final-newline t)                 ;POSIX改行
 '(scheme-program-name "gosh")
 '(scroll-step 1)                           ;最下段までScrollしてもカーソルを中心に戻さない
 '(skype--my-user-handle "ncaq__")
 '(tab-width 4)                             ;tab to 4 space
 '(warning-minimum-level :error)            ;quiet waring
 '(x-select-enable-clipboard t)             ;クリップボードをX11と共有
 )

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p) ;スクリプトに実行権限付加
(fset 'yes-or-no-p 'y-or-n-p)                                                   ;"yes or no"を"y or n"に
