(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"));リポジトリにMarmaladeを追加
(package-initialize);インストールしたパッケージにロードパスを通してロードする
