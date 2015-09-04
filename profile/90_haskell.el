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

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'ac-haskell-process-setup)
  (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup)
  (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup)

  (defun haskell-mode-stylish-buffer-and-save-buffer ()
    (interactive)
    (save-buffer)
    (haskell-mode-stylish-buffer))

  (with-eval-after-load 'haskell-interactive-mode (ncaq-set-key haskell-interactive-mode-map))

  (define-key haskell-mode-map (kbd "C-c C-d") 'hayoo)
  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer-and-save-buffer)
  )

(with-eval-after-load 'haskell
  (ncaq-set-key interactive-haskell-mode-map)
  (define-key interactive-haskell-mode-map (kbd "M-n") 'nil)
  (define-key interactive-haskell-mode-map (kbd "M-t") 'nil)
  )
