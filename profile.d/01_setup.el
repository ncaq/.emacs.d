;;http://d.hatena.ne.jp/khiker/20090711/emacsfullscreen
(set-frame-parameter nil 'fullscreen 'fullboth)   ; ウインドウマネージャの枠もなくなる完全な最大化(--fullscreenオプションをつけた場合と同じ)
;;(set-frame-parameter nil 'fullscreen 'maximized)  ; いわゆる右上の最大化するボタンを押しての最大化
;;(set-frame-parameter nil 'fullscreen 'nil)        ; 最大化してあった場合、元に戻す

(require 'server);;emacsclientのserverを立ち上げる
(unless (server-running-p)
  (server-start))
