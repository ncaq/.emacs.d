;; -*- lexical-binding: t -*-

(require 'whitespace)

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style '(face tabs spaces trailing))
 '(whitespace-action '(auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")
(set-face-background 'whitespace-tab "#0C2B33")

(defcustom whitespace-cleanup-disabled-hooks
  '(
    diff-mode-hook
    markdown-hook
    )
  "Called after whitespace-mode auto-cleanup is turned off."
  :type 'hook
  :group 'whitespace)

(defun whitespace-cleanup-turn-off ()
  (interactive)
  (setq-local whitespace-action (remove 'auto-cleanup whitespace-action)))

(mapc (lambda (h)(add-hook h 'whitespace-cleanup-turn-off)) whitespace-cleanup-disabled-hooks)
