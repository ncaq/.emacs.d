;; -*- lexical-binding: t -*-

(custom-set-variables
 '(gc-cons-percentage 10)               ; 10%以上作成したらGC
 '(gc-cons-threshold 16000000)          ; 16MB以上作成したらGC
 '(inhibit-startup-message t)           ; 起動時の画面無効
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")) ;melpaも追加
(package-initialize)                                                              ;インストールしたパッケージにロードパスを通してロードする

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'server)                       ;emacsclient
(unless (server-running-p)
  (server-start))

;; load-pathの設定
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list "~/.emacs.d/mine/"
            "~/.emacs.d/universe/"))

;;別ファイルから読み込む
(require 'init-loader)
(custom-set-variables '(init-loader-show-log-after-init nil))
(init-loader-load "~/.emacs.d/profile/") ;設定ファイルがあるディレクトリを指定

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

(kill-buffer-if-exist "*scratch*")
(kill-buffer-if-exist "*Compile-Log*")
