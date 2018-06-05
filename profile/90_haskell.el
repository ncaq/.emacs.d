;; -*- lexical-binding: t -*-

(custom-set-variables
 '(haskell-stylish-on-save t)
 '(intero-global-mode 1)
 )

(defun intero-repl-and-flycheck ()
  (interactive)
  (delete-other-windows)
  (flycheck-list-errors)
  (intero-repl)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer flycheck-error-list-buffer)
  (other-window 1)
  )

(with-eval-after-load 'intero
  (define-key intero-mode-map (kbd "C-M-z") 'intero-repl-and-flycheck)
  (flycheck-add-next-checker 'intero '(warning . haskell-hlint))
  )

(with-eval-after-load 'haskell-cabal (ncaq-set-key haskell-cabal-mode-map))

(defun hamlet-mode-config ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (electric-indent-local-mode -1)
  )

(put 'hamlet/basic-offset 'safe-local-variable 'integerp)

(add-hook 'hamlet-mode-hook 'hamlet-mode-config)

(flycheck-add-mode 'css-csslint 'shakespeare-lucius-mode)
(flycheck-add-mode 'javascript-eslint 'shakespeare-julius-mode)
