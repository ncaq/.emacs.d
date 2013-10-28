;;有効化して2行ぐらい書くだけのものはここに全部ツッコむ
(autoload 'minibuf-isearch "minibuf-isearch-mode")
(autoload 'sudden-death "sudden-death");突然の死

(require 'text-adjust)

(require 'undo-tree);;undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'yasnippet);;定型文補完
(yas-global-mode 1)

(require 'zlc)
(zlc-mode t)

(require 'wgrep)
(require 'ag)

(require 'root-tramp)
(require 'vs-move-beginning-of-line)

(require 'smooth-scroll)
(smooth-scroll-mode t)
