(require 'haskell-mode)
(require 'haskell-indentation)
(require 'haskell-doc)
(require 'ghc)
;; (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;; (add-hook 'haskell-mode-hook 'haskell-doc-mode)

(add-hook 'inferior-haskell-mode-hook 'ghci-completion-mode)

;;勝手にflymakeを割り当てられる
(setq ghc-previous-key    'nil)
(setq ghc-next-key        'nil)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)

(defun ncaq-haskell ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod))
  ;; (turn-on-haskell-indentation)
  ;; (turn-on-haskell-doc))
(add-hook 'haskell-mode-hook 'ncaq-haskell)
