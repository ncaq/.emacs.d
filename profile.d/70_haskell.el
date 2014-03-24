(require 'haskell-mode)
(require 'ghc)

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)
(add-to-list 'ac-modes 'inferior-haskell-mode)

(defun ncaq-haskell ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module))
;;(add-hook 'haskell-mode-hook 'ncaq-haskell)

(define-key haskell-mode-map (kbd "C-c f") nil)
(define-key haskell-mode-map (kbd "M-RET") 'newline-upper)

;;勝手にflymakeを割り当てられる
(setq ghc-next-key        (kbd "C-c C-M-n"))
(setq ghc-previous-key    (kbd "C-c C-M-p"))
