;; -*- lexical-binding: t -*-

(require 'whitespace)

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style '(face tabs spaces trailing space-before-tab space-after-tab))
 '(whitespace-action '(auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")

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

(defun whitespace-clean-disable (h)
  (add-hook h 'whitespace-cleanup-turn-off))

(mapc 'whitespace-clean-disable whitespace-cleanup-disabled-hooks)
