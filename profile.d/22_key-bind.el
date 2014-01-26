(global-set-key (kbd "C-+")	'text-scale-increase)
(global-set-key (kbd "C-,")	'helm-for-files);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key (kbd "C--")	'text-scale-decrease)
(global-set-key (kbd "C-.")	'helm-semantic-or-imenu)
(global-set-key (kbd "C-;")	'align-regexp);揃える(正規表現)
(global-set-key (kbd "C-^")	'dired-jump-to-current)
(global-set-key (kbd "C-a")	'vs-move-beginning-of-line);;Visual StdioライクなC-a
(global-set-key (kbd "C-h")	'backward-delete-char-untabify)
(global-set-key (kbd "C-j")	'helm-ag);インクリメント串刺し検索
(global-set-key (kbd "C-m")	'newline-and-indent);改行時にインデント
(global-set-key (kbd "C-o")	'helm-buffers-list)
(global-set-key (kbd "C-q")	'kill-buffer-and-window);バッファとウインドウ閉じる
(global-set-key (kbd "C-t")	'other-window)
(global-set-key (kbd "C-u")	'kill-whole-line);現在行を削除
(global-set-key (kbd "C-z")	'quoted-insert);C-qの本来の関数

(global-set-key (kbd "C-S-d")	'delete-horizontal-space);スペースを一気に消す
(global-set-key (kbd "C-S-h")	'c-hungry-backspace)

(global-set-key (kbd "M-,")	'helm-ls-git-ls)
(global-set-key (kbd "M-\\")	'delete-horizontal-space);前の改行も消すように
(global-set-key (kbd "M-c")	'help-command);HHKだとF1押しにくい
(global-set-key (kbd "M-h")	'backward-kill-word)
(global-set-key (kbd "M-j")	'ag-project)
(global-set-key (kbd "M-l")	'sort-lines);ソートする
(global-set-key (kbd "M-m")	'through-newline);
(global-set-key (kbd "M-n")	'forward-paragraph)
(global-set-key (kbd "M-o")	'ibuffer);もう一つのバッファーリスト
(global-set-key (kbd "M-p")	'backward-paragraph)
(global-set-key (kbd "M-q")	'delete-other-windows);他のウインドウを閉じる
(global-set-key (kbd "M-s")	'helm-occur)
(global-set-key (kbd "M-y")	'helm-show-kill-ring);多次元クリップボード
(global-set-key (kbd "M-z")	'repeat)

(global-set-key (kbd "C-M-d")	'kill-sexp)
(global-set-key (kbd "C-M-n")	'scroll-up-1)
(global-set-key (kbd "C-M-p")	'scroll-down-1)
(global-set-key (kbd "C-M-q")	'kill-buffer);バッファ閉じる

(global-set-key (kbd "C-M-S-q")	'kill-all-buffers);バッファを全て閉じる. まともに動かなくなるのですぐに終了すること

(global-set-key (kbd "C-x C-e")	'flycheck-list-errors)
(global-set-key (kbd "C-x C-f")	'save-buffer)
(global-set-key (kbd "C-x C-s")	'helm-find-files);;どう考えてもこっちのほうが便利だった

(global-set-key (kbd "C-c a")	'text-adjust-selective);全角記号とかそういうゴミな文字を変換する
(global-set-key (kbd "C-c c")	'quickrun);かしこいコンパイルコマンド実行
(global-set-key (kbd "C-c f")	'indent-whole-buffer);全ての文字に対し字下げを行う
(global-set-key (kbd "C-c g")	'magit-status)
(global-set-key (kbd "C-c j")	'open-junk-file);残るscratch
(global-set-key (kbd "C-c s")	'sdic)
