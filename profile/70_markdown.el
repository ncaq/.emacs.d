;; -*- lexical-binding: t -*-
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode));markdownの拡張子は.mdを採用

(setq markdown-command "pandoc")

(require 'auto-complete)
(add-to-list 'ac-modes 'markdown-mode)
