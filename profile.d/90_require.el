;;有効化して2行ぐらい書くだけのものはここに全部ツッコむ
;;自作
(require 'root-tramp)
(require 'vs-move-beginning-of-line)
(require 'symbolword-mode)

(require 'minibuf-isearch)

(require 'text-adjust)

(require 'undo-tree);;undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'zlc)
(zlc-mode t)

(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq smooth-scroll/vscroll-step-size 5);;デフォルトだと重い

;;＿人人人人人人＿
;;＞　突然の死　＜
;;￣ＹＹＹＹＹＹ￣
(require 'sudden-death)

(autoload 'sdic "sdic")
