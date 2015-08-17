;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(haskell-mode inferior-haskell-mode haskell-interactive-mode) ac-modes))
 '(haskell-stylish-on-save t)
 '(safe-local-variable-values (append '((haskell-process-use-ghci . t)
                                        (haskell-indent-spaces . 4))
                                      safe-local-variable-values))
 )

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

  (with-eval-after-load 'auto-complete
    (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup))

  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup))

  (defun haskell-mode-stylish-buffer-and-save-buffer()
    (interactive)
    (save-buffer)
    (haskell-mode-stylish-buffer))

  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer-and-save-buffer)
  (define-key haskell-mode-map (kbd "C-c C-d") 'hayoo)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  )
