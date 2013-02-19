;;小さい自作関数

(defun close-all-buffers (); => 
  "バッファ全部閉じる"
  (interactive); => 
  (mapc 'kill-buffer (buffer-list))); => close-all-buffers

(defun scroll-up-1 ()
  "カーソルを移動せずに画面を一行ずつスクロールhttp://d.hatena.ne.jp/uhiaha888/20101110/1289399913"
  (interactive) (scroll-up 1))
(defun scroll-down-1 ()
  "カーソルを移動せずに画面を一行ずつスクロールhttp://d.hatena.ne.jp/uhiaha888/20101110/1289399913"
  (interactive) (scroll-down 1))

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
    (code-format-all)
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

(defun is-point-whitespace ()
  "カーソルの位置は空白です 空白=( |\t|\n) else=nil"
  (and(looking-at "[\t ]")))
(defun is-backward-point-whitespace ()
  "カーソルの前の位置は空白"
  (save-excursion
    (backward-char)
    (is-point-whitespace)))
(defun is-forward-point-whitespace ()
  "カーソルの次の位置は空白"
  (save-excursion
    (forward-char)
    (is-point-whitespace)))
(defun is-reverse-point-whitespace-all ()
  "カーソルの位置の前には空白文字しかありません"
  (looking-back "^[\t ]+" ))

(defun move-beginning-of-line-Visual-Stdio-like ()
  "Visual StdioライクなC-a,通常はインデントに従いHomeへ,もう一度押すと本来のHome"
  (interactive)
  (cond
   ((is-reverse-point-whitespace-all) (move-beginning-of-line nil))
   (t (back-to-indentation))))
