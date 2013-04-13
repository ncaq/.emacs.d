;;flymake
;;makeファイルを使わない
(require 'flymake)
(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
		       temp-file
		       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" "-std=c++11" "-v" local-file))))
(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(add-hook 'c++-mode-hook 'flymake-mode-on)

;;リモートのファイルで固まらないように
(defvar flymake-run-in-place)
(setq flymake-run-in-place nil)

;;警告色が赤だとこのテーマだとめっちゃ見辛い
(set-face-background 'flymake-errline "#93a1a1")
(set-face-foreground 'flymake-errline "#202b36")
(set-face-background 'flymake-warnline "#93a1a1")
(set-face-foreground 'flymake-warnline "#053040")
