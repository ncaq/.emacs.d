;; package.el
(require 'package)
;;リポジトリにMarmaladeを追加
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)
