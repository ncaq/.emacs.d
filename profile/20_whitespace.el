;; -*- lexical-binding: t -*-

(require 'whitespace)

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style '(face tabs spaces trailing))
 '(whitespace-action '(auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")
(set-face-background 'whitespace-tab "#0C2B33")
(set-face-foreground 'whitespace-trailing "#332B28")

(defun whitespace-cleanup-turn-off ()
  (interactive)
  (setq-local whitespace-action (remove 'auto-cleanup whitespace-action)))

(add-hook 'markdown-mode-hook 'whitespace-cleanup-turn-off)
