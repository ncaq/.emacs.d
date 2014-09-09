;; -*- lexical-binding: t -*-
(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(custom-set-variables
 '(haskell-indentation-ifte-offset 4)
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-stylish-on-save t)
 )

(autoload 'haskell-echo-info-mode "haskell-echo-info")
(add-hook 'haskell-mode-hook 'haskell-echo-info-mode)

(require 'ghc)
(require 'auto-complete)
(defun ncaq/ghc-mod-setup ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module nil t))
(add-hook 'haskell-mode-hook 'ncaq/ghc-mod-setup t)

(setq ghc-import-key    (kbd "C-c i"))
(setq ghc-insert-key    (kbd "C-c m"))
(setq ghc-next-key      (kbd "C-c n"))
(setq ghc-previous-key  (kbd "C-c t"))
(setq ghc-sort-key      (kbd "C-c l"))

(define-key haskell-mode-map (kbd "C-M-'")                'ghc-check-insert-from-warning)
(define-key haskell-mode-map (kbd "C-c C-d")              'hayoo)
(define-key haskell-mode-map (kbd "C-c C-l")              'inferior-haskell-load-file)
(define-key haskell-mode-map [remap indent-whole-buffer]  'haskell-mode-stylish-buffer)
