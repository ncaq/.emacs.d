;; -*- lexical-binding: t -*-

(custom-set-variables '(nxml-slash-auto-complete-flag t))

(add-to-list 'auto-mode-alist '("\\.fxml\\'" . nxml-mode))

(with-eval-after-load 'nxml-mode
  (with-eval-after-load 'smartparens (sp-local-pair '(nxml-mode) "<" ">" :actions :rem))
  (ncaq-set-key nxml-mode-map)
  (define-key nxml-mode-map (kbd "C-M-p") 'nil)
  (define-key nxml-mode-map (kbd "C-M-t") 'nxml-backward-element)
  )