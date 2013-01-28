;;http://d.hatena.ne.jp/kitokitoki/20111217/
(add-to-list 'load-path "~/.emacs.d/haskell-mode-2.8.0")

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用


(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
