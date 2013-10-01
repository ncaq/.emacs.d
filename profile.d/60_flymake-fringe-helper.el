;;エラーをアイコンで表示する,シンタックスハイライトを消してしまうflymakeのエラー表示とはおさらば
;;処理自体を消す方法は見つからなかったので仕方なく表示だけ消しておいた
;;https://gist.github.com/bkudria/759130
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
