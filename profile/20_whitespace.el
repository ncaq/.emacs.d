;; -*- lexical-binding: t -*-

(require 'cl)                           ;reduce

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style (reduce (lambda (a x) (remove x a)) '(lines space-mark newline-mark) :initial-value whitespace-style))
 '(whitespace-action (list 'auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")

(add-hook 'markdown-mode '(lambda () (setq-local whitespace-action (remove 'auto-cleanup whitespace-action))))
