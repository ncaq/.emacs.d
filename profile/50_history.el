;; -*- lexical-binding: t -*-

(require 'recentf-ext)
(require 'recentf-remove-sudo-tramp-prefix)

(custom-set-variables
 '(backup-directory-alist `(("" . ,(concat user-emacs-directory "file-backup/"))))
 '(delete-old-versions t)            ;askだと削除時に一々聞いてくる
 '(kept-new-versions 50)             ;backupに新しいものをいくつ残すか
 '(kept-old-versions 0)              ;backupに古いものをいくつ残すか
 '(make-backup-files t)              ;バックアップファイルを作成する。
 '(vc-make-backup-files t)           ;VCS以下のファイルもバックアップを作成する
 '(version-control t)                ;複数バックアップ

 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(tramp-auto-save-directory temporary-file-directory)

 '(message-log-max 100000)

 '(savehist-mode t)
 '(savehist-minibuffer-history-variables
   (cons 'extended-command-history savehist-minibuffer-history-variables))

 '(desktop-save-mode t)
 '(desktop-globals-to-save nil)
 '(desktop-restore-frames nil)

 '(recentf-max-saved-items 2000)
 '(helm-ff-file-name-history-use-recentf t)
 '(recentf-auto-cleanup (* 15 60))
 '(recentf-exclude '("\\.elc$"
                     "\\.o$"
                     "~$"

                     "\\.file-backup/"
                     "\\.undo-tree/"

                     "EDITMSG"
                     "PATH"
                     "TAGS"
                     "autoloads"
                     ))
 )

(defun setq-buffer-backed-up-nil (&rest _) (interactive) (setq buffer-backed-up nil))
(advice-add 'save-buffer :before 'setq-buffer-backed-up-nil)

(save-place-mode 1)

(recentf-remove-sudo-tramp-prefix-mode 1)
