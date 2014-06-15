;; -*- lexical-binding: t -*-
(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)
(add-to-list 'ac-modes 'inferior-haskell-mode)

(require 'ghc)
(defun ghc-mod-setup ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module nil t))
(add-hook 'haskell-mode-hook 'ghc-mod-setup t)

(setq ghc-import-key    (kbd "C-c M-m"))
(setq ghc-insert-key    (kbd "C-c C-t"))
(setq ghc-next-key      (kbd "C-c C-M-n"))
(setq ghc-previous-key  (kbd "C-c C-M-t"))
(setq ghc-sort-key      (kbd "C-c M-l"))

(require 'haskell-echo-type)
(add-hook 'haskell-mode-hook 'turn-on-haskell-echo-type)

(define-key haskell-mode-map [remap indent-whole-buffer] (lambda () (interactive)(message "disable")))