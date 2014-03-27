(autoload 'sdic "sdic")
(autoload 'sudden-death "sudden-death")
(autoload 'text-adjust "text-adjust-selective")

(require 'minibuf-isearch)
(require 'root-tramp)
(require 'symbolword-mode)
(require 'vs-move-beginning-of-line)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'server);emacsclient
(unless (server-running-p)
  (server-start))

(require 'smooth-scroll)
(smooth-scroll-mode)
(setq smooth-scroll/vscroll-step-size 5);デフォルトだと重い

(require 'undo-tree);undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'forward)

(require 'windmove)
(setq windmove-wrap-around);Window移動をループする
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

(require 'zlc)
(zlc-mode)
