;;flymake
;; (require 'flymake)

;;コピペ始め
;;http://d.hatena.ne.jp/kitokitoki/20101230
;;エラーをアイコンで表示して,シンタックスハイライトを消してしまうflymakeのエラー表示とはおさらば
;;処理自体を消す方法は見つからなかったので仕方なく表示だけ消しておいた
(require 'fringe-helper)
(require 'flymake)

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
	 'left-fringe 'font-lock-warning-face)
	flymake-fringe-overlays))

(defadvice flymake-delete-own-overlays (after remove-from-fringe activate
					      compile)
  (mapc 'fringe-helper-remove flymake-fringe-overlays)
  (setq flymake-fringe-overlays nil))

(provide 'flymake-fringe-icons)
;;コピペ終わり

;;C++でmakeファイルを使わない時の設定
;;書き捨て
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


;;nilにしてしまえ
(defun flymake-highlight-line (line-no line-err-info-list)
  "Highlight line LINE-NO in current buffer.
Perhaps use text from LINE-ERR-INFO-LIST to enhance highlighting."
  (goto-char (point-min))
  (forward-line (1- line-no))
  (let* ((line-beg (point-at-bol))
	 (line-end (point-at-eol))
	 (beg      line-beg)
	 (end      line-end)
	 (tooltip-text (flymake-ler-text (nth 0 line-err-info-list)))
	 (face     nil))

    (goto-char line-beg)
    (while (looking-at "[ \t]")
      (forward-char))

    (setq beg (point))

    (goto-char line-end)
    (while (and (looking-at "[ \t\r\n]") (> (point) 1))
      (backward-char))

    (setq end (1+ (point)))

    (when (<= end beg)
      (setq beg line-beg)
      (setq end line-end))

    (when (= end beg)
      (goto-char end)
      (forward-line)
      (setq end (point)))

    ;; (if (> (flymake-get-line-err-count line-err-info-list "e") 0)
    ;; 	(setq face 'flymake-errline)
    ;;   (setq face 'flymake-warnline))

    (flymake-make-overlay beg end tooltip-text face nil)))
