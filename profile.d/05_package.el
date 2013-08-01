(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"));リポジトリにMarmaladeを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"));;melpaも追加
(package-initialize);インストールしたパッケージにロードパスを通してロードする

(require 'auto-install);;Emacswikiとかからinstallしてくる
(setq auto-install-directory "~/.emacs.d/auto-install.d/")

