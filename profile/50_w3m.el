;; -*- lexical-binding: t -*-

(eval-after-load 'w3m
  '(progn
    (custom-set-variables
     '(w3m-default-display-inline-images t))

    (define-key w3m-mode-map (kbd "n") 'next-line)
    (define-key w3m-mode-map (kbd "s") 'forward-char)
    (define-key w3m-mode-map (kbd "t") 'previous-line)

    (define-key w3m-mode-map (kbd "b") 'w3m-history)
    (define-key w3m-mode-map (kbd "c") 'w3m-lnum)
    (define-key w3m-mode-map (kbd "i") 'w3m-search)
    (define-key w3m-mode-map (kbd "m") 'w3m-view-this-url)

    (define-key w3m-mode-map (kbd "H") 'w3m-view-previous-page)
    (define-key w3m-mode-map (kbd "S") 'w3m-view-next-page)

    (define-key w3m-mode-map (kbd "C-t") 'nil)
    (define-key w3m-mode-map (kbd "M-n") 'nil)
    (define-key w3m-mode-map (kbd "M-s") 'nil)

    (define-key w3m-mode-map (kbd "<C-tab>")           'w3m-next-buffer)
    (define-key w3m-mode-map (kbd "<C-S-iso-lefttab>") 'w3m-previous-buffer)
    ))
