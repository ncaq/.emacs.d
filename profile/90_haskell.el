;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-modes (append '(haskell-mode inferior-haskell-mode haskell-interactive-mode) ac-modes))
 '(haskell-stylish-on-save t)
 '(haskell-indent-after-keywords '("where" "of" "do" "mdo" "rec" "in" "{" "if" "then" "else" "let"))
 '(hamlet/basic-offset 4)
 )

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook 'haskell-indent-mode)

  (with-eval-after-load 'auto-complete
    (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup))

  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup))

  (defun haskell-mode-stylish-buffer-and-save-buffer ()
    (interactive)
    (save-buffer)
    (haskell-mode-stylish-buffer))

  (define-key haskell-mode-map [remap indent-whole-buffer] 'haskell-mode-stylish-buffer-and-save-buffer)
  (define-key haskell-mode-map (kbd "C-c C-d") 'hayoo)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  )
