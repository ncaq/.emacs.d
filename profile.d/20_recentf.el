(require 'recentf-ext);;recentfのディレクトリも表示する改造版
(setq recentf-max-menu-items  100000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

(run-at-time t 3600 'recentf-cleanup);定期的に削除をチェック
(run-with-idle-timer 300 t 'auto-save-buffers);一定時間放置したら削除をチェック
