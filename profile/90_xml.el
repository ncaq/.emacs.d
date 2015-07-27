;; -*- lexical-binding: t -*-

(custom-set-variables '(nxml-slash-auto-complete-flag t))

(add-to-list 'auto-mode-alist '("\\.fxml\\'" . nxml-mode))

(with-eval-after-load 'nxml-mode
  (with-eval-after-load 'smartparens (sp-local-pair '(nxml-mode) "<" ">" :actions :rem))

  (define-key nxml-mode-map (kbd "C-M-p") 'nil)
  (define-key nxml-mode-map (kbd "C-M-t") 'nxml-backward-element)

  (define-key nxml-mode-map (kbd "M-h") 'nil)
  (define-key nxml-mode-map (kbd "C-c h") 'nxml-mark-paragraph)
  )
