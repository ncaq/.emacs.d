;; ロードパスの設定
(add-to-list 'load-path "/home/ncaq/.emacs.d/install/")
;;サブディレクトリロードする奴
;;http://six-pence.blogspot.jp/2009/11/emacs-load-path.html
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "/home/ncaq/.emacs.d/site-lisp/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "/home/ncaq/.emacs.d/bigprogram.d/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")

;;別ファイルから読み込む
(require 'init-loader)
(init-loader-load "/home/ncaq/.emacs.d/profile.d/") ; 設定ファイルがあるディレクトリを指定

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((use-touten-for-comma) (use-kuten-for-period)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
