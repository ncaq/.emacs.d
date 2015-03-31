;; -*- lexical-binding: t -*-

(require 'whitespace)

(custom-set-variables
 '(global-whitespace-mode t)
 '(whitespace-style '(face tabs spaces trailing space-before-tab space-after-tab))
 '(whitespace-action '(auto-cleanup))
 )

(set-face-background 'whitespace-space "#073642")

(defcustom whitespace-auto-cleanup-action-disabled-hooks
  '(
    diff-mode-hook
    markdown-hook
    )
  "Called after whitespace-mode auto-cleanup is turned off."
  :group 'whitespace)

(defun whitespace-auto-cleanup-turn-off ()
  (interactive)
  (setq-local whitespace-action (remove 'auto-cleanup whitespace-action))
  )

(defun add-whitespace-auto-cleanup-action-disable-hook (h)
  (add-hook h 'whitespace-auto-cleanup-turn-off)
  )

(mapc 'add-whitespace-auto-cleanup-action-disable-hook 'whitespace-auto-cleanup-action-disabled-modes)
