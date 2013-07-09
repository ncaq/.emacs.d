;;バックアップファイルの保存場所を指定。
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.backupEmacs/"))
	    backup-directory-alist))

;;http://ubulog.blogspot.jp/2008/10/emacs.html
(setq make-backup-files t);バックアップファイルを作成する。

(setq version-control t)		;複数のバックアップを残します。世代。
(setq kept-new-versions 100000)		;新しいものをいくつ残すか
(setq kept-old-versions 100000)		;古いものをいくつ残すか
(setq vc-make-backup-files t)	;バージョン管理下のファイルもバックアップを作る。
