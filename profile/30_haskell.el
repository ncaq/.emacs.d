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
  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer-and-save-buffer)
  (define-key haskell-mode-map (kbd "C-c C-d") 'hayoo)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  )
