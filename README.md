#これは何?
Emacsの設定ディレクトリ

#ディレクトリ解説
+ elpa emacsのパッケージシステムが作ったディレクトリ
+ package.d バージョン管理システムで cloneしたEmacsLisp
+ profile.d initloader.elが起動時に読み込むディレクトリ
+ universe.d 管理されていないプログラムのディレクトリ

#depend
* portage
  * atool
  * clang
  * git
  * global
  * haskell-platform
* cabal:
  * ghc-mod

#License
ncaqが書いた部分はGPLv3
