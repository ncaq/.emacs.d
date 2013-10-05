(require 'recentf)
(require 'recentf-ext)
(require 'recentf-purge-tramp)
(setq recentf-max-menu-items  100000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

(add-hook 'after-init-hook
	  '(lambda ()
	     (run-with-idle-timer 300 t 'recentf-cleanup)));一定時間放置したら削除をチェック
