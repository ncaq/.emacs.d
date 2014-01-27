(require 'haskell-mode)
(require 'haskell-indentation)
(require 'haskell-doc)
(require 'ghc)

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

(add-hook 'inferior-haskell-mode-hook 'ghci-completion-mode)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)

(defun ncaq-haskell ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module))
(add-hook 'haskell-mode-hook 'ncaq-haskell)

(define-key 'haskell-mode-map (kbd "C-M-m") nil)

;;勝手にflymakeを割り当てられる
(setq ghc-previous-key    (kbd "C-c C-c p"))
(setq ghc-next-key        (kbd "C-c C-c n"))
