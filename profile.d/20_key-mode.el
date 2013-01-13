;; C-kで行全体を削除
;; Vimのdd (行削除) に慣れた僕からすれば、C-kはぬるい。行全体削除するのにC-a C-k C-kって押さないといけない。めんどいので、行頭にいる場n合は最後の改行もまとめて削除するようにします。
;; C-kで行全体を削除
;;http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(setq kill-whole-line t)

;c-nした時に行を追加
(setq next-line-add-newlines t)

;;C-x C-fでファイルパスとURLを検索するみたい
;;http://www.bookshelf.jp/soft/meadow_23.html#SEC231
(ffap-bindings)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;;改行時のインデント
;;http://murakan.cocolog-nifty.com/blog/2009/01/emacs-tips-a8a4.html
(global-set-key "\C-m" 'newline-and-indent)
