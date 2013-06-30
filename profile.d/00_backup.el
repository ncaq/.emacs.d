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

;;http://d.hatena.ne.jp/i_k_b/20120924/1348462736
(setq backup-enable-predicate
      '(lambda (path)
         (and (normal-backup-enable-predicate path)
              (let ((name (file-name-nondirectory path)))
                (or (< (length name) 10)
                    (not (string-equal ".recentf" (substring name 0 10)))))
              )))
