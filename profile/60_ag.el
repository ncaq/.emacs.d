;; -*- lexical-binding: t -*-

(with-eval-after-load 'ag
  (ncaq-set-key ag-mode-map)
  (define-key ag-mode-map (kbd "C-o") 'nil)
  )
