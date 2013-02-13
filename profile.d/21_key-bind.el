(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'eval-buffer);C-cC-eでeval-bufferを実行
(global-set-key (kbd "C-,")			'anything);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key (kbd "C-;")			'foreign-regexp/align);正規表現揃え(perl)
(global-set-key (kbd "C-M-%")			'foreign-regexp/query-replace);正規表現置換(perl)
(global-set-key (kbd "C-M-S-q")			'close-all-buffers);バッファを全て閉じる.まともに動かなくなるのですぐに終了すること
(global-set-key (kbd "C-M-d")			'delete-horizontal-space);周辺の空白を全て削除
(global-set-key (kbd "C-M-r")			'foreign-regexp/isearch-backward);正規表現後方検索(perl)
(global-set-key (kbd "C-M-s")			'foreign-regexp/isearch-forward);正規表現前方検索(perl)
(global-set-key (kbd "C-\\")			'code-format-all);全ての文字に対し字下げを行う
(global-set-key (kbd "C-a")			'move-beginning-of-line-Visual-Stdio-like);;Visual StdioライクなC-a,通常はインデントに従いHomeへ,もう一度押すと本来のHome
(global-set-key (kbd "C-c c")			'compile);コンパイルコマンド
(global-set-key (kbd "C-c e S")			'evernote-do-saved-search)
(global-set-key (kbd "C-c e b")			'evernote-browser)
(global-set-key (kbd "C-c e c")			'evernote-create-note)
(global-set-key (kbd "C-c e o")			'evernote-open-note)
(global-set-key (kbd "C-c e p")			'evernote-post-region)
(global-set-key (kbd "C-c e s")			'evernote-search-notes)
(global-set-key (kbd "C-c e w")			'evernote-write-note)
(global-set-key (kbd "C-c q")			'quoted-insert);C-qの本来の関数
(global-set-key (kbd "C-c s")			'sort-lines);ソートする
(global-set-key (kbd "C-j")			'ff-find-other-file);ヘッダファイルに居る場合はソースファイルに,または逆
(global-set-key (kbd "C-o")			'anything-find-file);C-xC-fは頻繁に打つにしてはめんどくさい
(global-set-key (kbd "C-q")			'kill-buffer-and-window);C-qバッファ閉じる
(global-set-key (kbd "C-x C-s")			'disk);ファイルを保存する時に,外部から更新されてたら警告を出して保存しないコマンド.それ以外はsave-buffer
(global-set-key (kbd "C-z")			'recentf-open-most-recent-file);最後に閉じたバッファを開く
(global-set-key (kbd "M-j")			'open-junk-file);残るscratch
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)));http://d.hatena.ne.jp/uhiaha888/20101110/1289399913
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)));カーソルを移動せずに画面を一行ずつスクロール
(global-set-key (kbd "M-q")			'delete-other-windows);他のウインドウを閉じる
(global-set-key [f11]				'action-a-out);実行ファイル実行

;;C-hをBackSpaceに変更
(global-unset-key "\C-h")
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key (kbd "C-M-h") 'kill-whole-line)
;;http://stackoverflow.com/questions/13897125/emacs-translating-c-h-to-del-m-h-to-m-del
;;検索上でも効くように
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key isearch-mode-map "\C-h" 'isearch-delete-char)
	     (define-key isearch-mode-map "\M-h" 'isearch-del-char))));保留
