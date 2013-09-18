;; ロードパスの設定
;;http://d.hatena.ne.jp/kitokitoki/20100705/p1
(defun my-add-load-path-subdir (dirlist)
  (with-temp-buffer
    (dolist (dir dirlist)
      (cd dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path))))

(my-add-load-path-subdir
 '("~/.emacs.d/auto-install.d/"
   "~/.emacs.d/package.d/"
   "~/.emacs.d/universe.d/"))

;;何故か.elで終わるディレクトリは追加されない
(add-to-list 'load-path "~/.emacs.d/package.d/fringe-helper.el")
(add-to-list 'load-path "~/.emacs.d/package.d/sudden-death.el")
(add-to-list 'load-path "~/.emacs.d/package.d/ag.el")

;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d/") ; 設定ファイルがあるディレクトリを指定
