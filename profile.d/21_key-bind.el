(define-key emacs-lisp-mode-map	(kbd "C-c C-e")	'eval-buffer);C-cC-eでeval-bufferを実行
(global-set-key			(kbd "<f12>")	'action-a-out);実行ファイル実行
(global-set-key			(kbd "C-+")	'increment-string-as-number);数字増やす
(global-set-key			(kbd "C-,")	'anything);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key			(kbd "C--")	'decrement-string-as-number);数字減らす
(global-set-key			(kbd "C-;")	'align-regexp);揃える(正規表現)
(global-set-key			(kbd "C-M-S-q")	'close-all-buffers);バッファを全て閉じる.まともに動かなくなるのですぐに終了すること
(global-set-key			(kbd "C-M-d")	'kill-paragraph);段落削除
(global-set-key			(kbd "C-\\")	'code-format-all);全ての文字に対し字下げを行う
(global-set-key			(kbd "C-a")	'move-beginning-of-line-Visual-Stdio-like);;Visual StdioライクなC-a,通常はインデントに従いHomeへ,もう一度押すと本来のHome
(global-set-key			(kbd "C-c c")	'compile);コンパイルコマンド
(global-set-key			(kbd "C-c e S")	'evernote-do-saved-search)
(global-set-key			(kbd "C-c e b")	'evernote-browser)
(global-set-key			(kbd "C-c e c")	'evernote-create-note)
(global-set-key			(kbd "C-c e o")	'evernote-open-note)
(global-set-key			(kbd "C-c e p")	'evernote-post-region)
(global-set-key			(kbd "C-c e s")	'evernote-search-notes)
(global-set-key			(kbd "C-c e w")	'evernote-write-note)
(global-set-key			(kbd "C-c q")	'quoted-insert);C-qの本来の関数
(global-set-key			(kbd "C-c s")	'sort-lines);ソートする
(global-set-key			(kbd "C-j")	'ff-find-other-file);ヘッダファイルに居る場合はソースファイルに,または逆
(global-set-key			(kbd "C-o")	'anything-find-file);C-xC-fは頻繁に打つにしてはめんどくさい
(global-set-key			(kbd "C-q")	'kill-buffer-and-window);C-qバッファ閉じる
(global-set-key			(kbd "C-u")	'kill-whole-line);現在行を削除
(global-set-key			(kbd "C-x C-s")	'disk);ファイルを保存する時に,外部から更新されてたら警告を出して保存しないコマンド.それ以外はsave-buffer
(global-set-key			(kbd "C-z")	'recentf-open-most-recent-file);最後に閉じたバッファを開く
(global-set-key			(kbd "M-,")	'anything-kill-buffers);複数のバッファを簡単に閉じれる
(global-set-key			(kbd "M-\\")	'delete-horizontal-space);前の改行も消すように
(global-set-key			(kbd "M-j")	'open-junk-file);残るscratch
(global-set-key			(kbd "M-n")	'scroll-up-1);http://d.hatena.ne.jp/uhiaha888/20101110/1289399913
(global-set-key			(kbd "M-p")	'scroll-down-1);カーソルを移動せずに画面を一行ずつスクロール
(global-set-key			(kbd "M-q")	'delete-other-windows);他のウインドウを閉じる

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
