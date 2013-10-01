;;flymake
;;http://d.hatena.ne.jp/kitokitoki/20101230
(require 'flymake)

;;C++でmakeファイルを使わない時の設定
;;書き捨て
;; (defun flymake-cc-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-with-folder-structure))
;; 	 (local-file  (file-relative-name
;; 		       temp-file
;; 		       (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" "-std=c++11" "-v" local-file))))
;; (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
;; (add-hook 'c++-mode-hook 'flymake-mode-on)

;;リモートのファイルで固まらないように
(defvar flymake-run-in-place)
(setq flymake-run-in-place nil)

;;エラー無視
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;;!を消す
(defun flymake-make-overlay (beg end tooltip-text face bitmap mouse-face)
  "Allocate a flymake overlay in range BEG and END."
  (when (not (flymake-region-has-flymake-overlays beg end))
    (let ((ov (make-overlay beg end nil t t))
	  (fringe (and flymake-fringe-indicator-position
		       (propertize "" 'display
				   (cons flymake-fringe-indicator-position
					 (if (listp bitmap)
					     bitmap
					   (list bitmap)))))))
      (overlay-put ov 'face           face)
      (overlay-put ov 'mouse-face     mouse-face)
      (overlay-put ov 'help-echo      tooltip-text)
      (overlay-put ov 'flymake-overlay  t)
      (overlay-put ov 'priority 100)
      (overlay-put ov 'evaporate t)
      (overlay-put ov 'before-string fringe)
      ;;+(flymake-log 3 "created overlay %s" ov)
      ov)
    (flymake-log 3 "created an overlay at (%d-%d)" beg end)))
