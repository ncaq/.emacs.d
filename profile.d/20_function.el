(fset 'newline-under;下に改行
      [end return])
(fset 'newline-upper;上に改行
      [home return up])

(defun sort-lines-auto-paragrah-mark ()
  (interactive)
  (if (use-region-p)
      (sort-lines nil (region-beginning)(region-end))
    (progn
      (mark-paragraph)
      (sort-lines nil (region-beginning)(region-end)))))

(defun sort-whole-buffer ()
  (interactive)
  (mark-whole-buffer)
  (sort-lines nil (region-beginning)(region-end)))

(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

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

(defun indent-whole-buffer-and-brackets ()
  "括弧を揃える"
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

(defun delete-whitespace-backward ()
  (interactive)
  (when (looking-back " " 0)
    (backward-delete-char-untabify 1)
    (delete-whitespace-backward)))
