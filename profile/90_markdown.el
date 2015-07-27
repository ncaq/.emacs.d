;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "M-n") 'nil)
  (define-key markdown-mode-map (kbd "M-p") 'nil)

  (custom-set-variables '(markdown-command "pandoc"))
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
  )
