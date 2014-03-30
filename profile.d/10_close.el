(require 'undohist);;undoをファイル閉じても保存
(setq undohist-directory "~/.emacs.d/undohist")
(setq undohist-ignored-files ".*COMMIT_EDITMSG.*")
(undohist-initialize)
