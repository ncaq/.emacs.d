;; -*- lexical-binding: t -*-

(custom-set-variables
 '(web-mode-enable-current-column-highlight t)
 '(web-mode-enable-current-element-highlight t)
 '(web-mode-markup-indent-offset 2)
 )

(put 'web-mode-markup-indent-offset 'safe-local-variable 'integerp)

(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("html?\\'"       . web-mode))

(with-eval-after-load 'web-mode (sp-local-pair '(web-mode) "<" ">" :actions :rem))

(defun json-ncaq-setup () (setq-local js-indent-level 2))
(add-hook 'json-mode-hook 'json-ncaq-setup)
