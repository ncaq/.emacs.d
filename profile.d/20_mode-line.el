;;改行コードを表示
(setq eol-mnemonic-dos	"(CRLF)")
(setq eol-mnemonic-mac	"(CR)")
(setq eol-mnemonic-unix "(LF)")

;;フルパスを表示
(set-default 'mode-line-buffer-identification
	 '(buffer-file-name ("%f") ("%b")))
