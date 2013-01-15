;;http://d.hatena.ne.jp/syohex/20101224/1293206906
;;server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

(defun server-visit-edit-key ()
  (define-key global-map "\C-q" 'server-edit))

(add-hook 'server-visit-hook 'server-visit-edit-key)
