(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode));markdownの拡張子は.mdを採用

(setq markdown-command "markdown_py")

(require 'auto-complete)
(add-to-list 'ac-modes 'markdown-mode)
