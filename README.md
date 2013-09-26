#これは何?
Emacsの設定フォルダ

#ディレクトリ解説
+ package.d バージョン管理ソフトで cloneしたEmacsLisp
+ elpa emacsのパッケージシステムが作ったディレクトリ
+ template.d auto-insert用のテンプレート
+ auto-install.d auto-install.elがインストールしたEmacsLisp
+ profile.d initloader.elが起動時に読み込むディレクトリ
+ universe.d 全く管理されていないプログラムのディレクトリ

#普通`.emacs`だけじゃないの?
1ファイルだけに書いていられるか!俺は分割するぜ!  
init-loader.elを使って,分割してprofile.dに置いています.

#profile.d内のファイルの名前の先頭についている,数字の意味は
init-loader.elは,数字の少ないところから読み込んで,数字から始まってないファイルは読み込みません.
数字の基準は,

* 20 Emacs自体にある機能をいじる
* 21 key-mode->key-bindの読み込み順にしたかったため.
* 30 基準がわからない,当時の自分は何を考えていたのか
* 50 外部EmacsLispの読み込み,設定
* 60 auto-complete-clang等,外部プログラムを使うEmacsLispの設定
* 70 各ファイルのモード設定
* 90 きちんとファイルを一つ一つの拡張に割り当てると膨大になるので,2行ぐらいのはここに纏めて入れている
* 91 1行で完結するような設定はここに

#depend
* emerge
  * clang
  * git
  * haskell-platform
  * markdown
  * omake
  * gnu global
  * w3m-el
* cabal:
  * ghc-mod
  * hasktags
* build

#Emacs初心者のため助言ください
[Twitter](https://twitter.com/ncaq)
<nyrigadake38@gmail.com>
等で連絡をください.

#License
ncaqが書いた部分に付いてはPublic Domainです.
他のはurl先や,ファイル自体に書かれているライセンスに当然従います.
再配布しないでという方は連絡ください.
Emacs関係だから,そのままの再配布を拒むようなライセンスが混じってはいないはずだけれども.
