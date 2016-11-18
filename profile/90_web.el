;; -*- lexical-binding: t -*-

(put 'web-mode-markup-indent-offset 'safe-local-variable 'integerp)

(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"       . typescript-mode))

(with-eval-after-load 'web-mode
  (sp-local-pair '(web-mode) "<" ">" :actions :rem))

(defun json-ncaq-setup ()
  (setq-local js-indent-level 2))

(add-hook 'json-mode-hook 'json-ncaq-setup)

(add-hook 'typescript-mode-hook (lambda () (tide-setup)))
