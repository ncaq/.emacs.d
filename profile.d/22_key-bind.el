(define-key emacs-lisp-mode-map	(kbd "C-M-q")	'kill-buffer);なんか予め設定されてるから
(define-key emacs-lisp-mode-map	(kbd "C-c e")	'eval-buffer);C-cC-eでeval-bufferを実行
(define-key read-expression-map (kbd "<tab>") 	'lisp-complete-symbol);M-S-;
(global-set-key			(kbd "<f12>")	'action-a-out);実行ファイル実行
(global-set-key			(kbd "C-+")	'increment-string-as-number);数字増やす
(global-set-key			(kbd "C-,")	'anything-for-files);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key			(kbd "C--")	'decrement-string-as-number);数字減らす
(global-set-key			(kbd "C-;")	'align-regexp);揃える(正規表現)
(global-set-key			(kbd "C-M-S-q")	'close-all-buffers);バッファを全て閉じる.まともに動かなくなるのですぐに終了すること
(global-set-key			(kbd "C-M-d")	'kill-paragraph);段落削除
(global-set-key			(kbd "C-M-l")	'sort-lines);ソートする
(global-set-key			(kbd "C-M-n")	'scroll-up-1);http://d.hatena.ne.jp/uhiaha888/20101110/1289399913
(global-set-key			(kbd "C-M-p")	'scroll-down-1);カーソルを移動せずに画面を一行ずつスクロール
(global-set-key			(kbd "C-M-q")	'kill-buffer);バッファ閉じる
(global-set-key			(kbd "C-M-z")	'recentf-open-most-recent-file);最後に閉じたバッファを開く
(global-set-key			(kbd "C-S-d")	'delete-horizontal-space);スペースを一気に消す
(global-set-key			(kbd "C-a")	'move-beginning-of-line-Visual-Stdio-like);;Visual StdioライクなC-a
(global-set-key			(kbd "C-c a")	'text-adjust-selective);全角記号とかそういうゴミな文字を変換する
(global-set-key			(kbd "C-c c")	'mode-compile);かしこいコンパイルコマンド実行
(global-set-key			(kbd "C-c f")	'code-format-all);全ての文字に対し字下げを行う
(global-set-key			(kbd "C-c h")	'help-command);HHKだとF1押しにくい
(global-set-key			(kbd "C-c j")	'open-junk-file);残るscratch
(global-set-key			(kbd "C-j")	'anything-do-grep);インクリメント串刺し検索
(global-set-key			(kbd "C-m")	'newline-and-indent);改行時にインデント
(global-set-key			(kbd "C-o")	'overwrite-mode);所謂insertモード
(global-set-key			(kbd "C-q")	'kill-buffer-and-window);バッファとウインドウ閉じる
(global-set-key			(kbd "C-u")	'kill-whole-line);現在行を削除
(global-set-key			(kbd "C-x C-e") 'flymake-display-err-menu-for-current-line);現在の行のエラー表示
(global-set-key			(kbd "C-z")	'quoted-insert);C-qの本来の関数
(global-set-key			(kbd "M-,")	'ibuffer);もう一つのバッファーリスト
(global-set-key			(kbd "M-\\")	'delete-horizontal-space);前の改行も消すように
(global-set-key			(kbd "M-l")	'sdic)
(global-set-key			(kbd "M-m")	'through-newline);
(global-set-key			(kbd "M-n")	'forward-paragraph)
(global-set-key			(kbd "M-p")	'backward-paragraph)
(global-set-key			(kbd "M-q")	'delete-other-windows);他のウインドウを閉じる
(global-set-key			(kbd "M-y")	'anything-show-kill-ring);多次元クリップボード
(global-set-key			(kbd "M-z")	'ff-find-other-file);ヘッダファイルに居る場合はソースファイルに,または逆

;;C-hをBackSpaceに変更
(global-unset-key (kbd "C-h"))
(global-set-key (kbd "C-M-h")	'backward-kill-sentence)
(global-set-key (kbd "C-S-h")	'c-hungry-backspace)
(global-set-key (kbd "C-h")	'c-electric-backspace)
(global-set-key (kbd "M-h")	'backward-kill-word)
;;http://stackoverflow.com/questions/13897125/emacs-translating-c-h-to-del-m-h-to-m-del
;;検索上でも効くように
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
	     (define-key isearch-mode-map (kbd "M-h") 'isearch-del-char))));保留