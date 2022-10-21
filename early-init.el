;; GCを起動して即座に緩める。
(setq gc-cons-threshold 200000000)            ; 200MB

;; GUIを構築前に無効化する。
(setq menu-bar-mode nil)
(setq tool-bar-mode nil)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
