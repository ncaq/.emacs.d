(require 'evernote-mode)

(setq evernote-username "ykgaj");べ,別に特定が嫌で別の名前使ってるわけじゃないから書いても問題ないんだからねっ
(setq evernote-password-cache t);パスワードをキャッシュする,ファイルのアップロードはしていないので探すなよ
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ;XHTML関係?よくわかんない
