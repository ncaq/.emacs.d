;; -*- lexical-binding: t -*-

(custom-set-variables
 '(web-mode-enable-current-column-highlight t)
 '(web-mode-enable-current-element-highlight t)
 '(web-mode-markup-indent-offset 2)
 )

(put 'web-mode-markup-indent-offset 'safe-local-variable 'integerp)

(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'"      . web-mode))

(flycheck-add-mode 'javascript-eslint 'web-mode)
(add-hook 'web-mode-hook '(lambda ()
                            (if (or
                                 (string= web-mode-content-type "javascript")
                                 (string= web-mode-content-type "jsx"))
                                (prettier-js-mode))))

(with-eval-after-load 'web-mode (sp-local-pair '(web-mode) "<" ">" :actions :rem))
