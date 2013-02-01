#これは何?
Emacsの設定フォルダ.

#ディレクトリ解説
+ bigprogram.d git cloneしたEmacsLisp
+ elpa emacsのパッケージシステムが作ったディレクトリ
+ insert auto-insert用のテンプレート
+ install auto-install.elがインストールしたEmacsLisp
+ profile.d initloader.elが起動時に読み込むディレクトリ
+ site-lisp 全く管理されていないEmacsLispのディレクトリ

#普通`.emacs`だけじゃないの?
1ファイルだけに書いていられるか!俺は分割するぜ!  
init-loader.elを使って,profile.dに分割して置いています.

#うわ,なんか数字たくさんある
init-loader.elは,数字の少ないところから読み込んで,数字から始まってないファイルは読み込みません.  
数字の基準は,

* 20 Emacs自体にある機能をいじる
* 21 key-mode->key-bindの読み込み順にしたかったため.
* 30 基準がわからない,当時の自分は何を考えていたのか
* 50 外部EmacsLispの読み込み,設定
* 60 auto-complete-clang等,外部プログラムを使うEmacsLispの設定
* 70 各ファイルのモード設定

#何故○○のような方法を使ってカスタマイズしているのか
[Twitter](https://twitter.com/ncaq)
<nyrigadake38@gmail.com>
等で連絡をください.大歓迎です.

#License
ncaqが書いた部分に付いてはPublic Domainです.
