#これは何?
Emacsの設定ディレクトリ

#ディレクトリ解説
+ auto-install.d auto-install.elがインストールしたEmacsLisp
+ elpa emacsのパッケージシステムが作ったディレクトリ
+ package.d バージョン管理ソフトで cloneしたEmacsLisp
+ profile.d initloader.elが起動時に読み込むディレクトリ
+ template.d auto-insert用のテンプレート
+ universe.d 全く管理されていないプログラムのディレクトリ

#普通`.emacs`だけじゃないの?
1ファイルだけに書いていられないので,分割する。  
init-loader.elを使って,分割してprofile.dに置いています.

#depend
* emerge
  * atool
  * clang
  * git
  * gnu global
  * haskell-platform
* cabal:
  * ghc-mod
  * hasktags

#Emacs初心者のため助言ください
Issueとかで

#License
ncaqが書いた部分に付いてはGPLv3です.
他のはurl先や,ファイル自体に書かれているライセンスに当然従います.
