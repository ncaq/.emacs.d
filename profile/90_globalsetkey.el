;; -*- lexical-binding: t -*-

(global-set-key (kbd "C-+")     'text-scale-increase)
(global-set-key (kbd "C--")     'text-scale-decrease)
(global-set-key (kbd "C-.")     'helm-semantic-or-imenu)
(global-set-key (kbd "C-;")     'toggle-input-method)
(global-set-key (kbd "C-=")     'text-scale-reset)
(global-set-key (kbd "C-\\")    'indent-whole-buffer);全ての文字に対し字下げを行う
(global-set-key (kbd "C-^")     'dired-jump-to-current)
(global-set-key (kbd "C-a")     'smart-move-beginning-of-line)
(global-set-key (kbd "C-j")     'helm-ag);インクリメント串刺し検索
(global-set-key (kbd "C-m")     'newline-and-indent);改行時にインデント
(global-set-key (kbd "C-o")     'helm-buffers-list)
(global-set-key (kbd "C-q")     'kill-buffer-and-window)
(global-set-key (kbd "C-u")     'kill-whole-line);現在行を削除
(global-set-key (kbd "C-z")     'quoted-insert);C-qの本来の関数

(global-set-key (kbd "C-S-b")   'smart-delete-whitespace-backward)
(global-set-key (kbd "C-S-d")   'delete-horizontal-space);スペースを一気に消す

(global-set-key (kbd "M-,")     'mc/mark-all-dwim)
(global-set-key (kbd "M-\\")    'delete-horizontal-space);前の改行も消すように
(global-set-key (kbd "M-c")     'help-command);HHKだとF1押しにくい
(global-set-key (kbd "M-j")     'ag)
(global-set-key (kbd "M-l")     'sort-lines-auto-mark-paragrah)
(global-set-key (kbd "M-m")     'newline-under);
(global-set-key (kbd "M-o")     'helm-for-files);C-xC-bは頻繁に打つにしてはめんどくさい
(global-set-key (kbd "M-q")     'delete-other-windows);他のウインドウを閉じる
(global-set-key (kbd "M-u")     'universal-argument);C-u本来
(global-set-key (kbd "M-y")     'helm-show-kill-ring);多次元クリップボード
(global-set-key (kbd "M-z")     'repeat-complex-command)

(global-set-key (kbd "C-M-,")   'mc/edit-lines)
(global-set-key (kbd "C-M-;")   'align-regexp);揃える(正規表現)
(global-set-key (kbd "C-M-d")   'kill-sexp)
(global-set-key (kbd "C-M-l")   'sort-lines-whole-buffer)
(global-set-key (kbd "C-M-m")   'newline-upper)
(global-set-key (kbd "C-M-o")   'ibuffer);もう一つのバッファーリスト
(global-set-key (kbd "C-M-q")   'delete-window)

(global-set-key (kbd "C-M-S-q") 'kill-all-buffers)

(global-set-key (kbd "C-c a")   'text-adjust-selective);全角記号とかを変換する
(global-set-key (kbd "C-c c")   'quickrun);かしこいコンパイルコマンド実行
(global-set-key (kbd "C-c g")   'magit-status)
(global-set-key (kbd "C-c j")   'open-junk-file);残るscratch
(global-set-key (kbd "C-c m")   'mu4e)
(global-set-key (kbd "C-c s")   'sdic)

(global-set-key (kbd "C-c n")   'google-translate-at-point-reverse)
(global-set-key (kbd "C-c r")   'revert-buffer)
(global-set-key (kbd "C-c t")   'google-translate-at-point)
(global-set-key (kbd "C-x C-f") 'find-file-at-point)
