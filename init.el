;; -*- lexical-binding: t -*-

(setq gc-cons-threshold 134217728);128MB
(setq inhibit-startup-message);起動時の画面無効

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")) ;melpaも追加
(package-initialize)                                                              ;インストールしたパッケージにロードパスを通してロードする

(require 'server)                       ;emacsclient
(unless (server-running-p)
  (server-start))

;; ロードパスの設定
;;http://d.hatena.ne.jp/kitokitoki/20100705/p1
(defun my-add-load-path-subdir (dirlist)
  (with-temp-buffer
    (dolist (dir dirlist)
      (cd dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path))))
(my-add-load-path-subdir
 '("~/.emacs.d/mine/"
   "~/.emacs.d/universe/"))

;;別ファイルから読み込む
(require 'init-loader)
(custom-set-variables '(init-loader-show-log-after-init nil))
(init-loader-load "~/.emacs.d/profile/") ;設定ファイルがあるディレクトリを指定

(kill-buffer "*scratch*")
