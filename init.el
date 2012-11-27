;;http://d.hatena.ne.jp/syohex/20101224/1293206906
;;server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; ロードパスの設定
(setq load-path (append (list
			 (expand-file-name "~/.emacs.d/site-lisp")
			 (expand-file-name "~/.emacs.d/install")
                         )
                        load-path))

;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d") ; 設定ファイルがあるディレクトリを指定
