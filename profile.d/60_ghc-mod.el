;; ghc-mod
;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))

;;ghc-modのパス追加
(autoload 'ghc-init "ghc" nil t)
