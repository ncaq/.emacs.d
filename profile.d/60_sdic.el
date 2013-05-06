(require 'sdic)

(require 'sdic-inline)
(sdic-inline-mode t);sdic-inline モードの起動
;; 辞書ファイルの設定
(setq sdic-inline-eiwa-dictionary "/usr/local/share/dict/gene.sdic")
(setq sdic-inline-waei-dictionary "/usr/local/share/dict/jedict.sdic")

(setq sdic-inline-word-at-point-strict t)
(setq sdic-inline-not-search-style 'word)  ; カーソル下の単語が前回辞書で引いた単語と同じである限り、再度辞書ではひかない。

(require 'sdic-inline-pos-tip)
(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show)

