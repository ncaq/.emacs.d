;; -*- lexical-binding: t -*-

(cl-delete-if (lambda (element) (equal (cdr element) 'markdown-mode)) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

(with-eval-after-load 'markdown-mode
  (ncaq-set-key markdown-mode-map)
  (custom-set-variables
   '(markdown-command "pandoc")
   '(markdown-fontify-code-blocks-natively t)
   '(markdown-hide-urls nil)
   )
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
  )
