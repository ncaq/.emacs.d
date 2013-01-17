;;http://d.hatena.ne.jp/syohex/20101224/1293206906
;;server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;;妥協の結果
;;そのまま他のバッファに移った場合?もう考えてない,無理.
;;モードに関らず,そのバッファのみのキーを変更するにはどうすれば良いのだ…私にはわからない…
(defun server-map-remove ()
  (global-set-key "\C-q" 'kill-buffer-and-window))
(defun server-visit-edit-key ()
  (local-set-key "\C-q" 'server-edit))
(add-hook 'server-visit-hook 'server-visit-edit-key)
(add-hook 'server-done-hook 'server-map-remove)
