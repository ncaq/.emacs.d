(global-unset-key "\C-h")

;;C-hをBackSpaceに変更
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

;;C-ccコンパイル
(global-set-key "\C-cc" 'compile)

;;他のウインドウを閉じる
;;==C-x1
(global-set-key "\C-t" 'delete-other-windows)

;;ヘッダファイルに居る場合はソースファイルに,またはその逆
(global-set-key "\M-t" 'ff-find-other-file)

;;バッファを閉じる,複数ウインドウだったらそのウインドウも
(global-set-key "\C-q" 'kill-buffer-and-window)

;;元々の関数を別に割り当て
(global-set-key "\C-cC-q" 'quoted-insert)

;;C-Qバッファ全部閉じる
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-S-q") 'close-all-buffers)

;;C-\で全ての文字に対し字下げを行う
(defun code-format-custom ()
  (interactive)
  (mark-whole-buffer)
  (indent-region(point-min)(point-max)))
(global-set-key (kbd "C-\\") 'code-format-custom)

;;C-cC-eでeval-bufferを実行
(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'eval-buffer)

