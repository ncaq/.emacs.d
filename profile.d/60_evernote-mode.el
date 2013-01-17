(require 'evernote-mode)

(setq evernote-username "ykgaj");べ,別に特定が嫌で別の名前使ってるわけじゃないから書いても問題ないんだからねっ
(setq evernote-password-cache t);パスワードをキャッシュする,ファイルのアップロードはしていないので探すなよ


(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ;XHTML関係みたい


(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)
