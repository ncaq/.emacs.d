(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(custom-set-variables
 '(markdown-command "pandoc")
 )

(require 'pandoc-mode)
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
