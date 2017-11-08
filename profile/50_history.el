;; -*- lexical-binding: t -*-

(custom-set-variables
 '(make-backup-files t)              ;バックアップファイルを作成する。
 '(version-control t)                ;複数バックアップ
 '(delete-old-versions t)            ;askだといちいち聞いてくる
 '(kept-new-versions 20)             ;backupに新しいものをいくつ残すか
 '(kept-old-versions 20)             ;backupに古いものをいくつ残すか
 '(backup-directory-alist `(("" . ,(concat user-emacs-directory "file-backup/"))))

 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(tramp-auto-save-directory temporary-file-directory)

 '(message-log-max 100000)

 '(savehist-mode t)

 '(desktop-save-mode t)
 '(desktop-globals-to-save nil)
 '(desktop-restore-frames nil)
 )

(defun recentf-setup ()
  (require 'recentf-ext)
  (require 'recentf-remove-sudo-tramp-prefix)
  (custom-set-variables
   '(recentf-max-saved-items (* recentf-max-saved-items 40))

   '(helm-ff-file-name-history-use-recentf t)
   '(recentf-auto-cleanup (* 15 60))

   '(recentf-exclude '(
                       "\\.elc$"
                       "\\.o$"
                       "~$"

                       "\\.file-backup/"
                       "\\.undo-tree/"

                       "EDITMSG"
                       "PATH"
                       "TAGS"
                       "autoloads"
                       ))))

(add-hook 'after-init-hook 'recentf-setup)

(require 'saveplace)
(setq-default save-place t)
