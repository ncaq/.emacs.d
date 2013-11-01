;;Haskell関係
(require 'haskell-mode-autoloads)

(require 'flycheck)
(add-hook 'haskell-mode-hook 'flycheck-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
