;;http://d.hatena.ne.jp/higepon/20090505/
(defvar gdb-many-windows)
(setq gdb-many-windows t);有用なバッファを開くモード
(defvar gdb-use-separate-io-buffer)
(setq gdb-use-separate-io-buffer t);I/O バッファを表示
(defvar gud-tooltip-echo-area)
(setq gud-tooltip-echo-area t);t にすると mini buffer に値が表示される

(defun ncaq-gud ()
   (global-set-key (kbd "<f10>")	'gud-cont);ブレークポイントに会うまで実行
   (global-set-key (kbd "<f8>")	'gud-next);1行進む
   (global-set-key (kbd "<f9>")	'gud-step);1行進む.関数に入る
   (global-set-key (kbd "C-c h")	'gud-break);ブレークポイント設置
   (global-set-key (kbd "C-c d")	'gud-remove);ブレークポイント削除
   (global-set-key (kbd "C-c p")	'gud-tbreak);一時的なブレークポイント設置
   (global-set-key (kbd "C-c t")	'gud-print);変数の値を見る
   (global-set-key (kbd "C-c u")	'gud-until);現在の行まで実行
   (global-set-key (kbd "S-<f9>")'gud-finish);step out 現在のスタックフレームを抜ける
   (global-set-key (kbd "C-c v")	'gud-pv))
(add-hook 'gdb-mode-hook 'ncaq-gud)
