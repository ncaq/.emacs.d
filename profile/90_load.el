;; -*- lexical-binding: t -*-
(autoload 'sdic "sdic")
(autoload 'sudden-death "sudden-death")
(autoload 'text-adjust "text-adjust-selective")

(autoload 'open-junk-file "open-junk-file")
(custom-set-variables '(open-junk-file-format "~/Documents/log/%Y_%m/"))

(require 'root-tramp)
(require 'symbolword-mode)
(require 'ncaq-emacs-utils)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'server);emacsclient
(unless (server-running-p)
  (server-start))

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'forward)

(require 'windmove)
(setq windmove-wrap-around t);Window移動をループする
(windmove-default-keybindings);shift + arrow keyでウィンドウ移動

(require 'zlc-autoloads)
(zlc-mode t)

(require 'minibuf-isearch)
(define-key minibuffer-local-map (kbd "M-t") 'previous-history-element)

(require 'skype)
(setq skype--my-user-handle "ncaq__")