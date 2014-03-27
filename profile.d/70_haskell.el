(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

(require 'auto-complete)
(add-to-list 'ac-modes 'haskell-mode)
(add-to-list 'ac-modes 'inferior-haskell-mode)

(require 'ghc-autoloads)
(defun ghc-mod-setup ()
  (ghc-init)
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-hook 'after-save-hook 'ghc-import-module nil t))
(add-hook 'haskell-mode-hook 'ghc-mod-setup t)

;;勝手にflymakeを割り当てられる
(defvar ghc-next-key		(kbd "C-c C-M-n"))
(defvar ghc-previous-key	(kbd "C-c C-M-p"))

(define-key haskell-mode-map (kbd "C-c f") '(lambda () (message "Haskell is not free style language!")))
(define-key haskell-mode-map (kbd "M-RET") 'newline-upper)
