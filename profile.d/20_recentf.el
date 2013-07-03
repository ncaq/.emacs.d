(require 'recentf-ext);;recentfのディレクトリも表示する改造版
(setq recentf-max-menu-items 10000);;メニュー表示件数
(setq recentf-max-saved-items 100000);;保存件数

;;何故かrecentfのバックアップファイルだけおかしな出現をするため
(add-hook 'kill-emacs-hook '(lambda ()
			      (shell-command "rm .\#.recentf")))
