;; -*- lexical-binding: t -*-

(with-eval-after-load 'eww
  (custom-set-variables
   '(eww-search-prefix "https://www.google.co.jp/search?q="))

  (define-key eww-mode-map (kbd "b") 'backward-char)
  (define-key eww-mode-map (kbd "f") 'forward-char)
  (define-key eww-mode-map (kbd "p") 'previous-line)
  (define-key eww-mode-map (kbd "n") 'next-line)

  (define-key eww-mode-map (kbd "H") 'eww-back-url)
  (define-key eww-mode-map (kbd "S") 'eww-forward-url)

  (define-key eww-mode-map (kbd "c") 'eww-browse-with-external-browser)
  (define-key eww-mode-map (kbd "h") 'eww-history-browse)
  (define-key eww-mode-map (kbd "i") 'eww)
  (define-key eww-mode-map (kbd "m") 'ace-link-eww)

  (define-key eww-mode-map (kbd "M-p") 'nil)
  (define-key eww-mode-map (kbd "M-n") 'nil)

  (define-key eww-mode-map (kbd "<C-S-iso-lefttab>") 'eww-previous-buffer)
  (define-key eww-mode-map (kbd "<C-tab>")           'eww-next-buffer)
  )
