;;他のウインドウを閉じる
;;==C-x1
(global-set-key "\C-cw" 'delete-other-windows)

;;バッファを閉じる,複数ウインドウだったらそのウインドウも
(global-set-key "\C-q" 'kill-buffer-and-window)

;;履歴を開く
(global-set-key "\C-cf" 'anything-recentf)

;;コンパイル
(global-set-key "\C-cc" 'compile)

;; 対応する括弧に移動(C-M-f/p相当)
(global-set-key [?\C-{] 'backward-list)
(global-set-key [?\C-}] 'forward-list)
;;ヘッダファイルに居る場合はソースファイルに,またはその逆
(global-set-key "\M-t" 'ff-find-other-file)

;;C-M-\で全ての文字に対し字下げを行う
(defun code-format-custom ()
  (interactive)
  (mark-whole-buffer)
  (indent-region(point-min)(point-max)))

(define-key global-map [(control meta \\)] 'code-format-custom)

