(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない
(setq frame-title-format (format "%%b"));タイトルバーにバッファ名を表示する

;;mode-lineに改行コードを表示
(setq eol-mnemonic-dos  "(CRLF)")
(setq eol-mnemonic-mac  "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;mode-lineフルパスを表示
(set-default 'mode-line-buffer-identification '(buffer-file-name ("%f") ("%b")))

;;mode-line line and char numbar
(setq mode-line-position
      '(:eval (format "l%%l/%d,c%d/%d"
		      (count-lines (point-max)(point-min))
		      (point)
		      (- (point-max)(point-min)))))
