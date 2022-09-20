;; GCの設定。
(setq gc-cons-threshold 200000000)            ; 200MB
(run-with-idle-timer 120 t #'garbage-collect) ; 2分のアイドル時間ごとに明示的にガベージコレクトを呼び出す

;; GUI設定。
(setq menu-bar-mode nil)
(setq tool-bar-mode nil)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obsolete)
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
