(require 'sdic)

(require 'sdic-inline)
(sdic-inline-mode t)   ; sdic-inline モードの起動
;; 辞書ファイルの設定
(setq sdic-inline-eiwa-dictionary "/usr/share/dict/gene.sdic")
(setq sdic-inline-waei-dictionary "/usr/share/dict/jedict.sdic")

(require 'sdic-inline-pos-tip)
(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show)
