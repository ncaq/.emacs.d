(require 'desktop)
(desktop-save-mode t)

;; ロードパスの設定
;;http://d.hatena.ne.jp/kitokitoki/20100705/p1
(defun my-add-load-path-subdir (dirlist)
  (with-temp-buffer
    (dolist (dir dirlist)
      (cd dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path))))
(my-add-load-path-subdir
 '("~/.emacs.d/package.d/"
   "~/.emacs.d/universe.d/"
   "/usr/local/share/"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"));;melpaも追加
(package-initialize);インストールしたパッケージにロードパスを通してロードする

;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "~/.emacs.d/profile.d/") ; 設定ファイルがあるディレクトリを指定
