(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない
(set-frame-parameter nil 'fullscreen 'maximized);gtk maxium

(auto-image-file-mode 1);画像表示

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
                      number-of-line-buffer
                      (point)
                      (point-max))))
(defvar-local number-of-line-buffer 0)
(defun set-number-of-line-buffer ()
  (setq number-of-line-buffer (+ 1 (count-screen-lines))))
(add-hook 'find-file-hook 'set-number-of-line-buffer)
(add-hook 'after-save-hook 'set-number-of-line-buffer)