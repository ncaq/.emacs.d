;; -*- lexical-binding: t -*-

(custom-set-variables
 '(web-mode-enable-auto-indentation nil)
 '(web-mode-enable-auto-quoting nil)
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
(add-to-list 'auto-mode-alist '("\\.jsx\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"      . web-mode))

(with-eval-after-load 'web-mode (sp-local-pair '(web-mode) "<" ">" :actions :rem))

(flycheck-add-mode 'html-tidy 'web-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)

(add-hook
 'web-mode-hook
 '(lambda ()
    (cond
     ((string= web-mode-content-type "html")
      (when (executable-find "tidy") (flycheck-select-checker 'html-tidy)))
     ((or (string= web-mode-content-type "javascript") (string= web-mode-content-type "jsx"))
      (when (executable-find "eslint") (flycheck-select-checker 'javascript-eslint))
      (prettier-js-mode)))))

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
