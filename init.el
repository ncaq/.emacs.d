;; ロードパスの設定
(add-to-list 'load-path "~/.emacs.d/install/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d/") ; 設定ファイルがあるディレクトリを指定
