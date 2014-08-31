;; -*- lexical-binding: t -*-

(require 'w3m)

(define-key w3m-mode-map (kbd "b") 'w3m-history)
(define-key w3m-mode-map (kbd "c") 'w3m-lnum)
(define-key w3m-mode-map (kbd "n") 'next-line)
(define-key w3m-mode-map (kbd "s") 'forward-char)
(define-key w3m-mode-map (kbd "t") 'previous-line)

(define-key w3m-mode-map (kbd "H") 'w3m-view-previous-page)
(define-key w3m-mode-map (kbd "S") 'w3m-view-next-page)

(define-key w3m-mode-map (kbd "C-t") 'nil)
(define-key w3m-mode-map (kbd "M-n") 'nil)
(define-key w3m-mode-map (kbd "M-s") 'nil)
