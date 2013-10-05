;;改行コードを表示
(setq eol-mnemonic-dos	"(CRLF)")
(setq eol-mnemonic-mac	"(CR)")
(setq eol-mnemonic-unix "(LF)")

;;フルパスを表示
(set-default 'mode-line-buffer-identification
	 '(buffer-file-name ("%f") ("%b")))

(which-function-mode 1);ウィンドウの下部に現在の関数名を表示します。
(custom-set-faces '(which-func ((t (:foreground "#a3a1a1")))));;現在の函数表示,デフォルトだと色がかぶって見辛い
