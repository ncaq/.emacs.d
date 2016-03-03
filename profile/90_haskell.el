;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(haskell-mode inferior-haskell-mode haskell-interactive-mode) ac-modes))
 '(hamlet/basic-offset 4)
 '(haskell-indentation-ifte-offset 4)
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 2)
 '(haskell-indentation-where-pre-offset 2)
 '(haskell-process-suggest-language-pragmas nil)
 '(haskell-stylish-on-save t)
 )

(defun turn-off-flycheck-mode ()
  (flycheck-mode -1))

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'turn-off-flycheck-mode)
  )

(with-eval-after-load 'haskell
  (ncaq-set-key interactive-haskell-mode-map)
  (define-key interactive-haskell-mode-map (kbd "M-n") 'nil)
  (define-key interactive-haskell-mode-map (kbd "M-t") 'nil)
  )

(with-eval-after-load 'haskell-cabal            (ncaq-set-key haskell-cabal-mode-map))
(with-eval-after-load 'haskell-interactive-mode (ncaq-set-key haskell-interactive-mode-map))

(add-to-list 'load-path (concat (car (file-expand-wildcards "~/.cabal/share/*-ghc-*/*ghc-mod*/elisp")) "/"))
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook 'ghc-init)

(defun ghc-user-init ()
  (add-to-list 'ac-sources 'ac-source-ghc-mod))
(advice-add 'ghc-init :after 'ghc-user-init)

(defvar ghc-display-error 'minibuffer)

(defvar ghc-document-key   (kbd "C-c C-d"))
(defvar ghc-help-key       (kbd "C-z"))
(defvar ghc-info-key       (kbd "C-c d"))
(defvar ghc-insert-key     (kbd "C-M-'"))
(defvar ghc-next-hole-key  (kbd "C-c M-n"))
(defvar ghc-next-key       (kbd "M-g M-n"))
(defvar ghc-prev-hole-key  (kbd "C-c M-t"))
(defvar ghc-previous-key   (kbd "M-g M-t"))
(defvar ghc-sort-key       (kbd "C-c M-g l"))
(defvar ghc-type-key       (kbd "C-c C-t"))

(flycheck-add-mode 'css-csslint 'shakespeare-lucius-mode)
(flycheck-add-mode 'javascript-jshint 'shakespeare-julius-mode)
