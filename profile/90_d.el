;; -*- lexical-binding: t -*-

(with-eval-after-load 'd-mode
  (define-key d-mode-map [remap indent-whole-buffer] 'dfmt-region-or-buffer)

  (defun ncaq-d-setup ()
    (custom-set-variables '(c-basic-offset 4))
    (add-hook 'before-save-hook 'dfmt-buffer nil t)
    )

  (add-hook 'd-mode-hook 'ncaq-d-setup)
  )
