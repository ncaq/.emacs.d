;; -*- lexical-binding: t -*-

(with-eval-after-load 'haskell-mode
  (custom-set-variables
   '(haskell-indentation-ifte-offset 4)
   '(haskell-indentation-layout-offset 4)
   '(haskell-indentation-left-offset 4)
   '(haskell-stylish-on-save t)
   )
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

  (add-to-list 'ac-modes 'haskell-interactive-mode)
  (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup)

  (defun haskell-mode-stylish-buffer-and-save-buffer()
    (interactive)
    (save-buffer)
    (haskell-mode-stylish-buffer))
  (define-key haskell-mode-map [remap indent-whole-buffer]  'haskell-mode-stylish-buffer-and-save-buffer)

  (define-key haskell-mode-map (kbd "C-c C-d")              'hoogle)
  (define-key haskell-mode-map (kbd "C-c C-l")              'inferior-haskell-load-file)
  )

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook 'ghc-init)

(with-eval-after-load 'ghc
  (add-hook 'haskell-mode-hook '(lambda ()
                                  (add-to-list 'ac-sources 'ac-source-ghc-mod)))
  (add-hook 'after-save-hook 'ghc-import-module nil t)

  (set-face-underline 'ghc-face-error 'unspecified)
  (set-face-underline 'ghc-face-warn 'unspecified)

  (defun ghc-show-info-minibuffer ()
    (interactive)
    (message "%s" (ghc-get-info (ghc-things-at-point))))
  (define-key haskell-mode-map (kbd "C-M-.") 'ghc-show-info-minibuffer)

  (define-key haskell-mode-map (kbd "C-M-'") 'ghc-check-insert-from-warning)

  (setq ghc-import-key   (kbd "C-c i"))
  (setq ghc-insert-key   (kbd "C-c m"))
  (setq ghc-next-key     (kbd "C-c ! n"))
  (setq ghc-previous-key (kbd "C-c ! t"))
  (setq ghc-sort-key     (kbd "C-c l"))
  )
