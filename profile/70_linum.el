;; -*- lexical-binding: t -*-
(require 'linum);;行番号を左に表示
(global-linum-mode)

;;ポップアップを出した時に荒ぶる問題の修正
(require 'auto-complete)
(defvar mozc-preedit-in-session-flag)
(defadvice linum-update
  (around tung/suppress-linum-update-when-popup activate)
  (unless (or (ac-menu-live-p) mozc-preedit-in-session-flag)
    ad-do-it))

;;更新頻度を低くして軽くする
;;http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 10 nil #'linum-update-current))
