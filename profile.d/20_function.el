;;小さい自作関数
(fset 'through-newline
      [end return])

(defun kill-all-buffers ()
  "バッファ全部閉じる"
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun indent-whole-buffer ()
  "自動で全選択→コードフォーマット"
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-region(point-min)(point-max))))

(defun indent-brackets-whole-buffer ()
  "括弧を揃えない人が多くて困るよね"
  (interactive)
  (save-excursion
    (while (re-search-forward ")[ 	]*{" nil t)
      (replace-match ")\n{"))
    (while (re-search-forward "=[ 	]*{" nil t)
      (replace-match "=\n{"))
    (indent-whole-buffer)
    ))

(defun action-a-out ()
  "currentdirのa.outを実行"
  (interactive)
  (defvar current-dir (expand-file-name "."));shell-command-to-stringには改行がくっついてくるので削除
  (start-process "a.out"
		 "*a.out*"
		 (concat current-dir "/a.out")))

(require'text-adjust)
(defun text-adjust-selective ()
  "text-adjustは色々やりすぎる"
  (interactive)
  (text-adjust-hankaku-buffer)
  (text-adjust-kutouten-buffer))
