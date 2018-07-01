;; -*- lexical-binding: t -*-

(defun set-hook-after-save-clang-format ()
  (add-hook 'after-save-hook 'clang-format-buffer t t))

(with-eval-after-load 'cc-mode
  (add-hook 'c-mode-hook 'set-hook-after-save-clang-format)
  (add-hook 'c++-mode-hook 'set-hook-after-save-clang-format)

  (ncaq-set-key c-mode-base-map)
  (define-key c-mode-map [remap indent-whole-buffer] 'clang-format-buffer)
  (define-key c++-mode-map [remap indent-whole-buffer] 'clang-format-buffer)
  )
