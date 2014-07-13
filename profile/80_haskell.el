;; -*- lexical-binding: t -*-
(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(autoload 'turn-on-haskell-echo-type "haskell-echo-type")
(autoload 'haskell-echo-type         "haskell-echo-type")
(add-hook 'haskell-mode-hook 'turn-on-haskell-echo-type)

(require 'ghc)
(defvar ac-sources)
(defun ghc-mod-setup ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module nil t))
(add-hook 'haskell-mode-hook 'ghc-mod-setup t)

(setq ghc-import-key    (kbd "C-c i"))
(setq ghc-insert-key    (kbd "C-c m"))
(setq ghc-next-key      (kbd "C-c n"))
(setq ghc-previous-key  (kbd "C-c t"))
(setq ghc-sort-key      (kbd "C-c l"))

(define-key haskell-mode-map (kbd "C-M-'") 'ghc-check-insert-from-warning)
(define-key haskell-mode-map [remap indent-whole-buffer] (lambda () (interactive)(message "disable")))