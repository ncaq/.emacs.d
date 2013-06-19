;;Haskell向けのautocomplete
;;バイトコンパイルするとなぜかエラーが出るので注意.普通の.elなら問題ない.
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))
(add-hook 'haskell-mode-hook '(add-to-list 'ac-sources 'ac-source-ghc-mod));auto-completeの情報源としてghc-modの補完を追加
