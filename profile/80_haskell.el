;; -*- lexical-binding: t -*-

(require 'haskell-echo-info-autoloads)

(eval-after-load 'haskell-mode
  '(progn
     (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

     (custom-set-variables
      '(haskell-indentation-ifte-offset 4)
      '(haskell-indentation-layout-offset 4)
      '(haskell-indentation-left-offset 4)
      '(haskell-stylish-on-save t)
      )

     (add-hook 'haskell-mode-hook 'haskell-echo-info-mode)

     (define-key haskell-mode-map (kbd "C-M-'")                'ghc-check-insert-from-warning)
     (define-key haskell-mode-map (kbd "C-c C-d")              'hayoo)
     (define-key haskell-mode-map (kbd "C-c C-l")              'inferior-haskell-load-file)
     (define-key haskell-mode-map [remap indent-whole-buffer]  'haskell-mode-stylish-buffer)
     ))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook 'ghc-init)

(eval-after-load 'ghc
  '(progn
     (add-to-list 'ac-sources 'ac-source-ghc-mod)
     (add-hook 'after-save-hook 'ghc-import-module nil t)
     (setq ghc-import-key    (kbd "C-c i"))
     (setq ghc-insert-key    (kbd "C-c m"))
     (setq ghc-next-key      (kbd "C-c ! n"))
     (setq ghc-previous-key  (kbd "C-c ! t"))
     (setq ghc-sort-key      (kbd "C-c l"))
     ))
