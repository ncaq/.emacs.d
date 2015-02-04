;; -*- lexical-binding: t -*-

(defvar backup-directory "~/.file-backup/")

(custom-set-variables
 '(make-backup-files t)              ;バックアップファイルを作成する。
 '(version-control t)                ;複数バックアップ
 '(delete-old-versions t)
 '(kept-new-versions 50)             ;backupに新しいものをいくつ残すか
 '(kept-old-versions 50)             ;backupに古いものをいくつ残すか
 '(backup-directory-alist `(("" . ,backup-directory)))
 '(tramp-auto-save-directory backup-directory)

 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

 '(message-log-max 5000)                ;ログの記録行数を増やす.

 '(recentf-max-saved-items 500)
 '(recentf-auto-cleanup 1000)
 '(recentf-exclude '(
                     "COMMIT_EDITMSG$"
                     "TAGS"
                     "\\.elc$"
                     "\\.o$"
                     "~$"
                     
                     "\\.file-backup/"
                     "\\.undo-tree/"
                     "trash/"
                     ))

 '(desktop-restore-frames nil)
 '(savehist-ignored-variables '(file-name-history))
 '(history-length 500)             ;ミニバッファの履歴の保存数を増やす
 )

(desktop-save-mode 1)
(savehist-mode 1)
(toggle-save-place-globally t)          ;fileのカーソル位置保存

(defvar recentf-list)
(defun sync-file-name-history-from-recentf ()
  (setq file-name-history recentf-list))

(defun recentf-setup ()
  "recentfによる .recentf の読み込みで,バックアップ位置がバグることへの対策"
  (require 'recentf)
  (require 'recentf-ext)
  (require 'recentf-purge-tramp)

  (recentf-mode 1)
  (run-with-idle-timer 600 t 'sync-file-name-history-from-recentf)
  )

(add-hook 'after-init-hook 'recentf-setup)
