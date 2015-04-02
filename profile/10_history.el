;; -*- lexical-binding: t -*-

(custom-set-variables
 '(make-backup-files t)              ;バックアップファイルを作成する。
 '(version-control t)                ;複数バックアップ
 '(delete-old-versions t)
 '(kept-new-versions 50)             ;backupに新しいものをいくつ残すか
 '(kept-old-versions 50)             ;backupに古いものをいくつ残すか
 '(backup-directory-alist `(("" . "~/.file-backup/")))

 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(tramp-auto-save-directory temporary-file-directory)
 '(auto-save-list-file-prefix (concat temporary-file-directory "auto-save-list/.saves-"))

 '(message-log-max 5000)                ;ログの記録行数を増やす.

 '(savehist-mode t)
 '(savehist-ignored-variables '(file-name-history))

 '(desktop-save-mode t)
 '(desktop-restore-frames nil)

 )

(defun recentf-setup ()
  (custom-set-variables
   '(recentf-max-saved-items 1000)

   '(helm-ff-file-name-history-use-recentf t)
   '(recentf-auto-cleanup 1000)

   '(recentf-exclude '(
                       "\\.elc$"
                       "\\.o$"
                       "~$"

                       "COMMIT_EDITMSG$"
                       "GPATH$"
                       "GRTAGS$"
                       "GTAGS$"
                       "TAGS$"

                       "\\.file-backup/"
                       "\\.undo-tree/"
                       ))
   )
  (require 'recentf-ext)
  (require 'recentf-remove-sudo-tramp-prefix)
  )

(add-hook 'after-init-hook 'recentf-setup)

(setq-default save-place t)
(require 'saveplace)
