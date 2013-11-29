;;Haskell関係
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(require 'ghc)
(add-hook 'haskell-mode-hook 'ghc-init)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)
