(require 'markdown-mode)
(require 'pandoc-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode));markdownの拡張子は.mdを採用

(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
