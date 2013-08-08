;;何故かrecentfのバックアップファイルだけおかしな出現をするため
(defun bug-recentf-del ()
  (shell-command "rm .\#.recentf"))
(add-hook 'kill-emacs-hook 'bug-recentf-del)

;;順番が大事
(require 'recentf-ext);;recentfのディレクトリも表示する改造版
(setq recentf-max-menu-items  100000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

;;trampのを通常のパスに
(require 'recentf-purge-tramp)
(recentf-purge-tramp)

(run-at-time t 1000 'recentf-cleanup);定期的に削除をチェック
(run-with-idle-timer 60 t 'auto-save-buffers);一定時間放置したらに削除をチェック
(bug-recentf-del)
