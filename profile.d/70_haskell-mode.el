;;Haskell関係
(require 'haskell-mode)
;;http://d.hatena.ne.jp/kitokitoki/20111217/
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;HasktagをAnythingで扱う
(require 'anything-hasktags)
(add-hook 'haskell-mode-hook
	  (lambda()
	    (define-key haskell-mode-map (kbd "C-.") 'anything-hasktags-select)))

;;AnythingとHaskellのなんかアレ
(defvar anything-c-source-ghc-mod
  '((name . "ghc-browse-document")
    (init . anything-c-source-ghc-mod)
    (candidates-in-buffer)
    (candidate-number-limit . 9999999)
    (action ("Open" . anything-c-source-ghc-mod-action))))

(defun anything-c-source-ghc-mod ()
  (unless (executable-find "ghc-mod")
    (error "ghc-mod を利用できません。ターミナルで which したり、*scratch* で exec-path を確認したりしましょう"))
  (let ((buffer (anything-candidate-buffer 'global)))
    (with-current-buffer buffer
      (call-process "ghc-mod" nil t t "list"))))

(defun anything-c-source-ghc-mod-action (candidate)
  (interactive "P")
  (let* ((pkg (ghc-resolve-package-name candidate)))
    (anything-aif (and pkg candidate)
        (ghc-display-document pkg it nil)
      (message "No document found"))))

(defun anything-ghc-browse-document ()
  (interactive)
  (anything anything-c-source-ghc-mod))

;;M-x anything-ghc-browse-document() に対応するキーの割り当て
;;ghc-mod の設定のあとに書いた方がよいかもしれません
(add-hook 'haskell-mode-hook
	  (lambda()
	    (define-key haskell-mode-map (kbd "C-M-\'") 'anything-ghc-browse-document)))
