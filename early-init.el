;; -*- lexical-binding: t; -*-

;; GCが発動するまでのメモリ制限を起動後即座に緩めます。
;; 大きな値を設定するとスループットは良くなります。
;; ただしレイテンシは悪くなる可能性があります。
;; しかし起動した後はgcmhパッケージの調整に任せるため、
;; 起動後のレイテンシはそこまで心配しなくても構いません。
;; よって最終的にgcmhパッケージが処理することを前提に、
;; 起動速度を重視してスループット最優先で設定します。
(setq gc-cons-threshold (* 4 1024 1024 1024)) ; 4GB

;; GUIメニューを構築前に無効化します。
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
