;; -*- lexical-binding: t -*-

(require 'company)
(require 'company-quickhelp)

(global-company-mode 1)
(company-quickhelp-mode 1)

(custom-set-variables
 '(company-dabbrev-code-other-buffers 'all)
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-other-buffers 'all)
 )

(ncaq-set-key company-active-map)
(dvorak-set-key company-search-map)

(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-b") 'nil)
