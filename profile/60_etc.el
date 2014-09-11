;; -*- lexical-binding: t -*-

(custom-set-variables
 '(blink-matching-paren                   nil)   ;括弧移動無効
 '(delete-by-moving-to-trash              t)     ;ごみ箱を有効
 '(diff-switches                          "-u")  ;diffをunifitedモードで
 '(indent-tabs-mode                       nil)   ;インデントをスペースで行う
 '(read-buffer-completion-ignore-case     t)     ;大文字と小文字を区別しない バッファ名
 '(read-file-name-completion-ignore-case  t)     ;大文字と小文字を区別しない ファイル名
 '(require-final-newline                  t)     ;POSIX改行
 '(scroll-step                            1)     ;最下段までScrollしてもカーソルを中心に戻さない
 '(trash-directory                        "~/trash/")
 '(x-select-enable-clipboard              t) ;クリップボードをX11と共有
 )

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p) ;スクリプトに実行権限付加
(fset 'yes-or-no-p 'y-or-n-p)                                                   ;"yes or no"を"y or n"に
