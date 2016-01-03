;; -*- lexical-binding: t -*-

(custom-set-variables '(safe-local-variable-values '((web-mode-markup-indent-offset . 2))))

(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))

(with-eval-after-load 'web-mode
  (sp-local-pair '(web-mode) "<" ">" :actions :rem))
