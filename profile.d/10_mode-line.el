;;http://d.hatena.ne.jp/sr10/20110227/1298735721
;;mode-lineは割合表示とかいらないので総行数を表示してください
;;http://d.hatena.ne.jp/sonota88/20110224/1298557375
;;総文字数も表示
(setq mode-line-position
      '(:eval (format "Line%%l/%d,Column%%c,Char%d/%d"
		      (count-lines (point-max)(point-min))
		      (point)
		      (- (point-max)(point-min)))))

;; 改行コードを表示
(setq eol-mnemonic-dos	"(CRLF)")
(setq eol-mnemonic-mac	"(CR)")
(setq eol-mnemonic-unix "(LF)")
