;; -*- lexical-binding: t -*-

(custom-set-variables
 '(make-backup-files t)                 ;バックアップファイルを作成する。
 '(version-control t)                   ;複数バックアップ
 
 '(backup-directory-alist '(("" . "~/.backup")))
 '(tramp-auto-save-directory "~/.backup")

 '(history-length 500)                  ;ミニバッファの履歴の保存数を増やす
 '(kept-new-versions 500)               ;backupに新しいものをいくつ残すか
 '(kept-old-versions 500)               ;backupに古いものをいくつ残すか
 '(message-log-max 5000)                ;ログの記録行数を増やす.

 '(save-place t)                        ;fileのカーソル位置保存

 '(recentf-max-saved-items 500)
 '(recentf-auto-cleanup 1000)
 '(recentf-exclude '(
                     "TAGS"
                     "\\.backup"
                     "\\.elc$"
                     "\\.o$"
                     "\\.undohist"
                     "trash"
                     "~$"
                     ))
 
 '(savehist-ignored-variables '(file-name-history))
 )

(desktop-save-mode 1)
(savehist-mode 1)

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
