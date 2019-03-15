;; -*- lexical-binding: t -*-

(require 'whitespace)

(custom-set-variables
 '(global-whitespace-mode 1)
 '(whitespace-action '(auto-cleanup))
 '(whitespace-style '(face tabs spaces trailing empty))
 )

(set-face-background 'whitespace-space "#073642")
(set-face-foreground 'whitespace-empty "#dc322f")
(set-face-foreground 'whitespace-tab "#0C2B33")
(set-face-foreground 'whitespace-trailing "#332B28")

(defun whitespace-cleanup-turn-off ()
  (interactive)
  (setq-local whitespace-action (remove 'auto-cleanup whitespace-action)))
