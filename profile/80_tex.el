;; -*- lexical-binding: t -*-
(require 'tex)
(require 'tex-buf)

(setq-default
 TeX-PDF-mode t
 TeX-command-default "xelatex"
 TeX-engine 'xetex
 latex-run-command "xelatex"
 )

(define-key TeX-mode-map (kbd "C-]") 'LaTeX-close-environment)