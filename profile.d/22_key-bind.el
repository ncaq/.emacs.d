(global-set-key			(kbd "C-,")	'helm-for-files);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key			(kbd "C-;")	'align-regexp);揃える(正規表現)
(global-set-key			(kbd "C-M-S-q")	'close-all-buffers);バッファを全て閉じる.まともに動かなくなるのですぐに終了すること
(global-set-key			(kbd "C-M-d")	'kill-sexp)
(global-set-key			(kbd "C-M-h")	'backward-kill-sentence)
(global-set-key			(kbd "C-M-l")	'sort-lines);ソートする
(global-set-key			(kbd "C-M-q")	'kill-buffer);バッファ閉じる
(global-set-key			(kbd "C-M-z")	'recentf-open-most-recent-file);最後に閉じたバッファを開く
(global-set-key			(kbd "C-S-d")	'delete-horizontal-space);スペースを一気に消す
(global-set-key			(kbd "C-S-h")	'c-hungry-backspace)
(global-set-key			(kbd "C-a")	'vs-move-beginning-of-line);;Visual StdioライクなC-a
(global-set-key			(kbd "C-c a")	'text-adjust-selective);全角記号とかそういうゴミな文字を変換する
(global-set-key			(kbd "C-c c")	'quickrun);かしこいコンパイルコマンド実行
(global-set-key			(kbd "C-c g")	'magit-status)
(global-set-key			(kbd "C-c j")	'open-junk-file);残るscratch
(global-set-key			(kbd "C-h")	'c-electric-backspace)
(global-set-key			(kbd "C-j")	'helm-ag);インクリメント串刺し検索
(global-set-key			(kbd "C-m")	'newline-and-indent);改行時にインデント
(global-set-key			(kbd "C-o")	'overwrite-mode);所謂上書きモード
(global-set-key			(kbd "C-q")	'kill-buffer-and-window);バッファとウインドウ閉じる
(global-set-key			(kbd "C-t")	'other-window)
(global-set-key			(kbd "C-u")	'kill-whole-line);現在行を削除
(global-set-key			(kbd "C-x C-b")	'helm-for-files)
(global-set-key			(kbd "C-x C-e")	'flycheck-list-errors)
(global-set-key			(kbd "C-x C-f")	'save-buffer)
(global-set-key			(kbd "C-x C-s")	'find-file-at-point)
(global-set-key			(kbd "C-z")	'quoted-insert);C-qの本来の関数
(global-set-key			(kbd "M-,")	'ibuffer);もう一つのバッファーリスト
(global-set-key			(kbd "M-\\")	'delete-horizontal-space);前の改行も消すように
(global-set-key			(kbd "M-c")	'help-command);HHKだとF1押しにくい
(global-set-key			(kbd "M-h")	'backward-kill-word)
(global-set-key			(kbd "M-j")	'ag-project)
(global-set-key			(kbd "M-l")	'sdic)
(global-set-key			(kbd "M-m")	'through-newline);
(global-set-key			(kbd "M-n")	'forward-paragraph)
(global-set-key			(kbd "M-p")	'backward-paragraph)
(global-set-key			(kbd "M-q")	'delete-other-windows);他のウインドウを閉じる
(global-set-key			(kbd "M-s")	'helm-occur)
(global-set-key			(kbd "M-y")	'helm-show-kill-ring);多次元クリップボード
(global-set-key			(kbd "M-z")	'code-format-all);全ての文字に対し字下げを行う
