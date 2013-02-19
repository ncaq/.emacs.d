;;http://d.hatena.ne.jp/higepon/20090505/
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)));変数の上にマウスカーソルを置くと値を表示
(defvar gdb-many-windows)
(setq gdb-many-windows t);有用なバッファを開くモード
(defvar gdb-use-separate-io-buffer)
(setq gdb-use-separate-io-buffer t);I/O バッファを表示
(defvar gud-tooltip-echo-area)
(setq gud-tooltip-echo-area t);t にすると mini buffer に値が表示される

(defvar gud-mode-map)
(defun ncaq-gud ()
   (define-key gud-mode-map (kbd "<f10>")	'gud-cont);ブレークポイントに会うまで実行
   (define-key gud-mode-map (kbd "<f8>")	'gud-next);1行進む
   (define-key gud-mode-map (kbd "<f9>")	'gud-step);1行進む.関数に入る
   (define-key gud-mode-map (kbd "C-c b")	'gud-break);ブレークポイント設置
   (define-key gud-mode-map (kbd "C-c d")	'gud-remove);ブレークポイント削除
   (define-key gud-mode-map (kbd "C-c p")	'gud-print);変数の値を見る
   (define-key gud-mode-map (kbd "C-c t")	'gud-tbreak);一時的なブレークポイント設置
   (define-key gud-mode-map (kbd "C-c u")	'gud-until);現在の行まで実行
   (define-key gud-mode-map (kbd "S-<f9>")	'gud-finish);step out 現在のスタックフレームを抜ける
   (define-key gud-mode-map (kbd "C-c v")	'gud-pv))
(add-hook 'gdb-mode-hook 'ncaq-gud)
