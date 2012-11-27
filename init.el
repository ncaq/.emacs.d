;;http://d.hatena.ne.jp/syohex/20101224/1293206906
;;server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; ロードパスの設定
(add-to-list 'load-path "~/.emacs.d/install/")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d") ; 設定ファイルがあるディレクトリを指定
