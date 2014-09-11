;; -*- lexical-binding: t -*-

(custom-set-variables
 '(make-backup-files t)                 ;バックアップファイルを作成する。
 '(version-control t)                   ;複数バックアップ
 
 '(backup-directory-alist '(("" . "~/.backup")))
 '(tramp-auto-save-directory "~/.backup")

 '(history-length 200)                  ;ミニバッファの履歴の保存数を増やす
 '(kept-new-versions 100)               ;backupに新しいものをいくつ残すか
 '(kept-old-versions 100)               ;backupに古いものをいくつ残すか
 '(message-log-max 1000)                ;ログの記録行数を増やす.
 
 '(savehist-mode 1)                     ;minibufferの履歴を保存する
 '(savehist-ignored-variables '(file-name-history))

 '(desktop-save-mode 1)
 )

(defun recentf-setup ()
  "recentfによる .recentf の読み込みで,バックアップ位置がバグることへの対策"
  (custom-set-variables
   '(recentf-mode 1)
   '(recentf-max-saved-items 200)
   '(recentf-auto-cleanup 1000)
   '(recentf-exclude '(
                       "TAGS"
                       "\\.backup"
                       "\\.elc$"
                       "\\.o$"
                       "\\.undohist"
                       "trash"
                       "~$"
                       )))
  (require 'recentf)
  (require 'recentf-ext)
  (require 'recentf-purge-tramp)

  (defvar recentf-list)
  (setq file-name-history recentf-list)
  )

(add-hook 'after-init-hook 'recentf-setup)
