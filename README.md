#これは何?
Emacsの設定フォルダです.

#ディレクトリ解説
+ bigprogram.d git cloneしたEmacsLisp
+ elpa emacsのパッケージシステムが作ったディレクトリ
+ insert auto-insert用のテンプレート
+ install auto-install.elがインストールしたEmacsLisp
+ profile.d initloader.elが起動時に読み込むディレクトリ
+ site-lisp 全く管理されていないディレクトリ

#普通`.emacs`だけじゃないの?
1ファイルだけに書いていられるか!俺は分割するぜ!  
init-loader.elを使って,profile.dに入れています.

#うわ,なんか数字たくさんある
init-loader.elは,数字の少ないところから読み込んで,数字から始まってないファイルは読み込みません.  
数字の基準は,

* 20 Emacs自体にある機能をいじる
* 21 keyの読み込み順を固定したい
* 30 基準がわからん,何を考えていた
* 40 そんなものはなかった
* 50 外部EmacsLispの読み込み,設定
* 60 EmacsLispじゃないもの(clangとかの外部実行ファイルとか)を使うEmacsLispの設定
* 70 各ファイルのモード設定

#なんで公開したの?
githubアカウント持ってるのに何も公開してないとか寂しい.

#なんで○○みたいな方法取ってるの?
アホだからです.Twitterとかメールとかでツッコミ是非ください.
