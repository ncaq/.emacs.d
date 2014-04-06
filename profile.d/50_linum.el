(require 'linum);;行番号を左に表示
(require 'auto-complete)
(global-linum-mode)

;;ポップアップを出した時に荒ぶる問題の修正
(defadvice linum-update
  (around tung/suppress-linum-update-when-popup activate)
  (unless (ac-menu-live-p)
    ad-do-it))

;;更新頻度を低くして軽くする
;;http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 2 nil #'linum-update-current))