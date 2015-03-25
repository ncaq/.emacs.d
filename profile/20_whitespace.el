;; -*- lexical-binding: t -*-

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style '(face tabs spaces trailing space-before-tab space-after-tab))
 '(whitespace-action '(auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")

(add-hook 'markdown-mode '(lambda () (setq-local whitespace-action (remove 'auto-cleanup whitespace-action))))
