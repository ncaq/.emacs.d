;;$PATHをシェルと共有する
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'open-junk-file)
(setq open-junk-file-directory "~/Documents/log/%Y_%m/")
