;;Haskell関係
(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(require 'ghc)
(add-hook 'haskell-mode-hook 'ghc-init)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)


(defun ncaq-haskell-conf ()
  (add-to-list 'ac-sources 'ac-source-ghc-mod);ghc-modのソースをautocompleteに追加
  )

(add-hook 'haskell-mode-hook 'ncaq-haskell-conf)
