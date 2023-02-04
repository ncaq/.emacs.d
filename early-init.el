;; GCを起動して即座に緩める。
;; 1GBを設定値にする。
;; あまり大きな値を設定するとスループットは良くなるが、
;; インクリメンタルGC非対応の場合反応が悪くなることがある。
;; しかしどうせ起動した後はgcmhに任せるので気にしないこととする。
(setq gc-cons-threshold (* 1 1000 1000 1000))

;; GUIメニューを構築前に無効化する。
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
