;; -*- lexical-binding: t -*-
(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない
(set-frame-parameter nil 'fullscreen 'maximized);gtk maxium

(auto-image-file-mode 1);画像表示

(setq frame-title-format (format "%%f%%* %%m"));タイトルバーにバッファ名を表示する

;;mode-lineに改行コードを表示
(setq eol-mnemonic-dos  "(CRLF)")
(setq eol-mnemonic-mac  "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;mode-lineにフルパスを表示
(set-default 'mode-line-buffer-identification '(buffer-file-name ("%f") ("%b")))

;;mode-line line and char numbar
(setq mode-line-position '(:eval
                           (format "l%%l/%d,c%d/%%i"
                            number-of-line-buffer
                            (point))))
(defvar-local number-of-line-buffer (count-screen-lines))
(defun set-number-of-line-buffer ()
  (setq number-of-line-buffer (count-screen-lines)))
(add-hook 'after-revert-hook 'set-number-of-line-buffer)
(add-hook 'after-save-hook 'set-number-of-line-buffer)
(add-hook 'find-file-hook 'set-number-of-line-buffer)
(run-with-idle-timer 30 t 'set-number-of-line-buffer)