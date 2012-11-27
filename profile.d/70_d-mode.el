;;; 70_d-mode.el --- D言語用の設定

;; Copyright (C) 2012  ncaq

;; Author: ncaq <ncaq@ncaq-Inspiron-N5110-LinuxMint>

(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))
