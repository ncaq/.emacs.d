;;小さい自作関数
(defun close-all-buffers (); => 
  "バッファ全部閉じる"
  (interactive); => 
  (mapc 'kill-buffer (buffer-list))); => close-all-buffers

(defun code-format-all (); => 
  "自動で全選択→コードフォーマット"
  (interactive); => 
  (save-excursion; => 
    (mark-whole-buffer); => 
    (indent-region(point-min)(point-max)))); => code-format-custom

(defun code-format-c ()
  "括弧を揃えない人が多くて困るよね"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-regexp ")[ \t]+{" ")\n{")
    (goto-char (point-min))
    (replace-regexp "=[ \t]+{" "=\n{")
    (code-format-all)
    ))

(defun action-a-out (); =>
  "currentdirのa.outを実行"
  (interactive); => 
  (defvar current-dir (expand-file-name "."));shell-command-to-stringには改行がくっついてくるので削除
  (start-process "a.out"; =>
		 "*a.out*"; => 
		 (concat current-dir "/a.out"))); => action-a-out

(fset 'through-newline "\C-e\C-m")

(require'text-adjust)
(defun text-adjust-selective ()
  "text-adjustは色々やりすぎる"
  (interactive)
  (text-adjust-hankaku-buffer)
  (text-adjust-kutouten-buffer))
