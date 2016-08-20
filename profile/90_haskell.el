;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(haskell-mode inferior-haskell-mode haskell-interactive-mode) ac-modes))
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 2)
 '(haskell-indentation-where-pre-offset 2)
 '(haskell-stylish-on-save t)
 )

(add-hook 'flycheck-mode-hook 'flycheck-haskell-setup)

(put 'flycheck-ghc-language-extensions 'safe-local-variable 'listp)
(put 'hamlet/basic-offset              'safe-local-variable 'integerp)
(put 'haskell-indent-spaces            'safe-local-variable 'integerp)
(put 'haskell-process-use-ghci         'safe-local-variable 'booleanp)

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  )

(defun haskell-interactive-and-flycheck ()
  (interactive)
  (delete-other-windows)
  (haskell-interactive-switch)
  (let ((frame (split-window-below)))
    (flycheck-list-errors)))

(with-eval-after-load 'haskell
  (ncaq-set-key interactive-haskell-mode-map)
  (define-key interactive-haskell-mode-map (kbd "M-.") 'nil)
  (define-key interactive-haskell-mode-map (kbd "M-n") 'nil)
  (define-key interactive-haskell-mode-map (kbd "M-t") 'nil)
  (define-key interactive-haskell-mode-map (kbd "C-.") 'haskell-mode-jump-to-def-or-tag)
  (define-key interactive-haskell-mode-map (kbd "C-M-z") 'haskell-interactive-and-flycheck)
  )

(with-eval-after-load 'haskell-cabal            (ncaq-set-key haskell-cabal-mode-map))
(with-eval-after-load 'haskell-interactive-mode (ncaq-set-key haskell-interactive-mode-map))

(flycheck-add-mode 'css-csslint 'shakespeare-lucius-mode)
(flycheck-add-mode 'javascript-eslint 'shakespeare-julius-mode)

(defun hamlet-ncaq-setup ()
  (electric-indent-local-mode -1))

(add-hook 'hamlet-mode-hook 'hamlet-ncaq-setup)
