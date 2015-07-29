;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(with-eval-after-load 'markdown-mode
  (ncaq-set-key markdown-mode-map)
  (custom-set-variables '(markdown-command "pandoc"))
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
  )
