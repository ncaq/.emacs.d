(autoload 'sdic "sdic")
(require 'minibuf-isearch)
(require 'root-tramp)
(require 'sudden-death)
(require 'symbolword-mode)
(require 'text-adjust)
(require 'vs-move-beginning-of-line)

(require 'anzu)
(global-anzu-mode +1)

(require 'auto-save-buffers);本当の自動保存
(run-with-idle-timer 30 t 'auto-save-buffers)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'open-junk-file)
(setq open-junk-file-directory "~/Documents/log/%Y_%m/")

(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq smooth-scroll/vscroll-step-size 5);デフォルトだと重い

(require 'undo-tree);undoをtreeに,C-x C-uで起動
(global-undo-tree-mode)

(require 'windmove)
(setq windmove-wrap-around t);Window移動をループする
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

(require 'zlc)
(zlc-mode t)

(require 'server);emacsclient
(unless (server-running-p)
  (server-start))
