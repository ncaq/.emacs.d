;; -*- lexical-binding: t -*-

(with-eval-after-load 'eww
  (custom-set-variables
   '(eww-search-prefix "https://www.google.co.jp/search?q="))

  (define-key eww-mode-map (kbd "h") 'backward-char)
  (define-key eww-mode-map (kbd "n") 'next-line)
  (define-key eww-mode-map (kbd "s") 'forward-char)
  (define-key eww-mode-map (kbd "t") 'previous-line)

  (define-key eww-mode-map (kbd "H") 'eww-back-url)
  (define-key eww-mode-map (kbd "S") 'eww-forward-url)

  (define-key eww-mode-map (kbd "b") 'eww-history-browse)
  (define-key eww-mode-map (kbd "c") 'eww-browse-with-external-browser)
  (define-key eww-mode-map (kbd "i") 'eww)
  (define-key eww-mode-map (kbd "m") 'eww-lnum-follow)
  (define-key eww-mode-map (kbd "z") 'eww-lnum-universal)

  (define-key eww-mode-map (kbd "M-n") 'nil)
  (define-key eww-mode-map (kbd "M-p") 'nil)

  (define-key eww-mode-map (kbd "<C-S-iso-lefttab>") 'eww-previous-buffer)
  (define-key eww-mode-map (kbd "<C-tab>")           'eww-next-buffer)
  )
