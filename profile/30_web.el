;; -*- lexical-binding: t -*-

(custom-set-variables
 '(auto-mode-alist
   (append
    '(("\\.html\\'" web-mode)
      ("\\.xhtml\\'" . web-mode)
      ("\\.php\\'" . web-mode)
      )
    auto-mode-alist)))

(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "M-c") 'web-mode-element-close)
  )

(custom-set-variables '(scss-sass-options '("--cache-location" "'/tmp/.sass-cache/'" "--style" "expanded")))
