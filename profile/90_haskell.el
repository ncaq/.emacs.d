;; -*- lexical-binding: t -*-

(custom-set-variables '(haskell-stylish-on-save t))

(defun stylish-haskell-enable ()
  (interactive)
  (custom-set-variables '(haskell-stylish-on-save t)))

(defun stylish-haskell-disable ()
  (interactive)
  (custom-set-variables '(haskell-stylish-on-save nil)))

(with-eval-after-load 'haskell-mode
  (require 'lsp)
  (require 'lsp-haskell)
  (add-hook 'haskell-mode-hook 'lsp)

  (setq flymake-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks))

  (define-key haskell-mode-map (kbd "C-M-z")               'haskell-repl-and-flycheck)
  (define-key haskell-mode-map (kbd "C-c C-c")             'haskell-session-change-target)
  (define-key haskell-mode-map (kbd "C-c C-l")             'haskell-process-load-file)
  (define-key haskell-mode-map (kbd "C-c C-z")             'haskell-interactive-switch)
  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer)
  )

(with-eval-after-load 'haskell-interactive-mode (ncaq-set-key haskell-interactive-mode-map))

(defun haskell-repl-and-flycheck ()
  (interactive)
  (delete-other-windows)
  (flycheck-list-errors)
  (haskell-process-load-file)
  (haskell-interactive-switch)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer flycheck-error-list-buffer)
  (other-window 1)
  )

(with-eval-after-load 'haskell-cabal (ncaq-set-key haskell-cabal-mode-map))

(defun hamlet-mode-config ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (electric-indent-local-mode -1)
  )

(add-hook 'hamlet-mode-hook 'hamlet-mode-config)

(flycheck-add-mode 'css-csslint 'shakespeare-lucius-mode)
(flycheck-add-mode 'javascript-eslint 'shakespeare-julius-mode)
