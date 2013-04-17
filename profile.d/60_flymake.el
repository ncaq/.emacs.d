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
;; (set-face-background 'flymake-errline "#93a1a1")
;; (set-face-foreground 'flymake-errline "#202b36")
;; (set-face-background 'flymake-warnline "#93a1a1")
;; (set-face-foreground 'flymake-warnline "#053000")

;;http://d.hatena.ne.jp/kitokitoki/20101230
(require 'fringe-helper)

(set-face-background 'flymake-errline nil)    ;既存のフェイスを無効にする
(set-face-foreground 'flymake-errline nil)
(set-face-background 'flymake-warnline nil)
(set-face-foreground 'flymake-warnline nil)

(make-face 'my-flymake-warning-face)
(set-face-foreground 'my-flymake-warning-face "red")
(set-face-background 'my-flymake-warning-face "yelow")
(setq my-flymake-warning-face 'my-flymake-warning-face)

(defvar flymake-fringe-overlays nil)
(make-variable-buffer-local 'flymake-fringe-overlays)

(defadvice flymake-make-overlay (after add-to-fringe first
                                       (beg end tooltip-text face mouse-face)
                                       activate compile)
  (push (fringe-helper-insert-region
	 beg end
	 (fringe-lib-load (if (eq face 'flymake-errline)
			      fringe-lib-exclamation-mark
			    fringe-lib-question-mark))
	 'left-fringe 'my-flymake-warning-face)
	;; 'left-fringe 'font-lock-warning-face)        
        flymake-fringe-overlays))

(defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                              compile)
  (mapc 'fringe-helper-remove flymake-fringe-overlays)
  (setq flymake-fringe-overlays nil))
