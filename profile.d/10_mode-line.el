;;http://d.hatena.ne.jp/sr10/20110227/1298735721
;;mode-lineは割合表示とかいらないので総行数を表示してください
(setq mode-line-position
      '(:eval (format "L%%l/%d,C%%c"
                      (count-lines (point-max)
                                   (point-min)))))

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;http://d.hatena.ne.jp/sonota88/20110224/1298557375
;;リージョン内の行数と文字数をモードラインに表示する(範囲指定している時だけ)
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
			;;(count-lines-region (region-beginning) (region-end)) ;; これだとエコーエリアがチラつく
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))
