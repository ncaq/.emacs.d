;;他のウインドウを閉じる
;;==C-x1
(global-set-key "\C-t" 'delete-other-windows)

;;ヘッダファイルに居る場合はソースファイルに,またはその逆
(global-set-key "\M-t" 'ff-find-other-file)

;;バッファを閉じる,複数ウインドウだったらそのウインドウも
(global-set-key "\C-q" 'kill-buffer-and-window)

;;コンパイル
(global-set-key "\C-cc" 'compile)

;;C-M-\で全ての文字に対し字下げを行う
(defun code-format-custom ()
  (interactive)
  (mark-whole-buffer)
  (indent-region(point-min)(point-max)))
(define-key global-map [(control meta \\)] 'code-format-custom)
