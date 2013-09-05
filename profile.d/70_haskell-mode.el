;;Haskell関係
(autoload 'haskell-mode "haskell-mode")
;;http://d.hatena.ne.jp/kitokitoki/20111217/
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;HasktagをHelmで扱う
(autoload 'helm-hasktags "haskell-mode")
(add-hook 'haskell-mode-hook
	  (lambda()
	    (define-key haskell-mode-map (kbd "C-.") 'helm-hasktags-select)))

;;HelmとHaskellのなんかアレ
(defvar helm-c-source-ghc-mod
  '((name . "ghc-browse-document")
    (init . helm-c-source-ghc-mod)
    (candidates-in-buffer)
    (candidate-number-limit . 9999999)
    (action ("Open" . helm-c-source-ghc-mod-action))))

(defun helm-c-source-ghc-mod ()
  (unless (executable-find "ghc-mod")
    (error "ghc-mod を利用できません。ターミナルで which したり、*scratch* で exec-path を確認したりしましょう"))
  (let ((buffer (helm-candidate-buffer 'global)))
    (with-current-buffer buffer
      (call-process "ghc-mod" nil t t "list"))))

(defun helm-c-source-ghc-mod-action (candidate)
  (interactive "P")
  (let* ((pkg (ghc-resolve-package-name candidate)))
    (helm-aif (and pkg candidate)
        (ghc-display-document pkg it nil)
      (message "No document found"))))

(defun helm-ghc-browse-document ()
  (interactive)
  (helm helm-c-source-ghc-mod))

;;M-x helm-ghc-browse-document() に対応するキーの割り当て
;;ghc-mod の設定のあとに書いた方がよいかもしれません
(add-hook 'haskell-mode-hook
	  (lambda()
	    (define-key haskell-mode-map (kbd "C-M-\'") 'helm-ghc-browse-document)))
