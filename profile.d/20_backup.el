;;http://ubulog.blogspot.jp/2008/10/emacs.html
(setq make-backup-files t)		 ; バックアップファイルを作成する。
;; バックアップファイルの保存場所を指定。
(setq backup-directory-alist
	  (cons (cons "\\.*$" (expand-file-name "~/.backupforemacs/"))
			backup-directory-alist))

(setq version-control t)		; 複数のバックアップを残します。世代。
(setq kept-new-versions 10000)		; 新しいものをいくつ残すか
(setq kept-old-versions 10000)		; 古いものをいくつ残すか
(setq delete-old-versions t)	; 確認せずに古いものを消す。
(setq vc-make-backup-files t)	; バージョン管理下のファイルもバックアップを作る。
