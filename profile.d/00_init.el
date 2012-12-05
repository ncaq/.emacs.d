;;http://d.hatena.ne.jp/khiker/20090711/emacsfullscreen
;;(set-frame-parameter nil 'fullscreen 'fullboth)   ; ウインドウマネージャの枠もなくなる完全な最大化(--fullscreenオプションをつけた場合と同じ)
(set-frame-parameter nil 'fullscreen 'maximized)  ; いわゆる右上の最大化するボタンを押しての最大化
;;(set-frame-parameter nil 'fullscreen 'nil)        ; 最大化してあった場合、元に戻す

;;http://blog.goo.ne.jp/shihei_1951/e/cc8be74e8f330bb59539b30e4a234883
;; 起動時の画面はいらない
(setq inhibit-startup-message t)

(add-to-list 'load-path "~/.emacs.d/")
