;; ロードパスの設定
(add-to-list 'load-path "~/.emacs.d/install/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;;サブディレクトリロードする奴
;;http://six-pence.blogspot.jp/2009/11/emacs-load-path.html
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/bigprogram.d/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d/") ; 設定ファイルがあるディレクトリを指定

