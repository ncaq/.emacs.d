;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(haskell-mode inferior-haskell-mode haskell-interactive-mode) ac-modes))
 '(haskell-stylish-on-save t)
 '(haskell-indentation-ifte-offset 4)
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 2)
 '(haskell-indentation-where-pre-offset 2)
 '(hamlet/basic-offset 4)
 )

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

  (with-eval-after-load 'auto-complete
    (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup))

  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup))

  (with-eval-after-load 'haskell-interactive-mode
    (ncaq-set-key haskell-interactive-mode-map))

  (defun haskell-mode-stylish-buffer-and-save-buffer ()
    (interactive)
    (save-buffer)
    (haskell-mode-stylish-buffer))

  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer-and-save-buffer)
  (define-key haskell-mode-map (kbd "C-c C-d") 'hayoo)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  (define-key haskell-mode-map (kbd "C-c C-r") 'haskell-process-load-or-reload)
  )
