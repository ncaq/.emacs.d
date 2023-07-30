;; -*- lexical-binding: t; -*-

;; GCが発動するまでのメモリ制限を起動後即座に緩めます。
;; あまり大きな値を設定するとスループットは良くなりますが、
;; レイテンシで反応が悪くなります。
;; しかし起動した後はgcmhに任せるので起動時は大きくとってGCを減らします。
(setq gc-cons-threshold (* 2 1000 1000 1000))

;; GUIメニューを構築前に無効化します。
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
