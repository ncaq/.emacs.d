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

(defun through-newline ()
  "vimのO"
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(require 'text-adjust)
(defun text-adjust-selective ()
  "text-adjustは色々やりすぎる"
  (interactive)
  (text-adjust-hankaku-buffer)
  (text-adjust-kutouten-buffer))
