;; -*- lexical-binding: t -*-

(custom-set-variables
 '(css-indent-offset 2)
 '(js-indent-level 2)
 '(typescript-indent-level 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-enable-auto-indentation nil)
 '(web-mode-enable-auto-quoting nil)
 '(web-mode-enable-current-column-highlight t)
 '(web-mode-enable-current-element-highlight t)
 '(web-mode-markup-indent-offset 2)
 )

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

(with-eval-after-load 'web-mode
  (sp-local-pair '(web-mode) "<" ">" :actions :rem)
  (set-face-background 'web-mode-jsx-depth-1-face "#073844")
  (set-face-background 'web-mode-jsx-depth-2-face "#083C49")
  (set-face-background 'web-mode-jsx-depth-3-face "#08404F")
  (set-face-background 'web-mode-jsx-depth-4-face "#094554")
  (set-face-background 'web-mode-jsx-depth-5-face "#0A4D5E")
  )

(flycheck-add-mode 'html-tidy 'web-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'typescript-tslint 'web-mode)

(defun prettier-js-mode-enable ()
  (interactive)
  (prettier-js-mode t))

(defun prettier-js-mode-disable ()
  (interactive)
  (prettier-js-mode nil))

(defun tide-setting ()
  (tide-setup)
  (flycheck-add-mode 'typescript-tide 'web-mode)
  (flycheck-select-checker 'typescript-tide))

(defun web-mode-setting ()
  (cond
   ((string= web-mode-content-type "html")
    (progn
      (prettier-js-mode-enable)
      (when (executable-find "tidy") (flycheck-select-checker 'html-tidy))))
   ((string-match-p "\\.tsx?$" (buffer-file-name)) (tide-setting))
   ((or (some (lambda (type) (string= web-mode-content-type type)) '("javascript" "jsx")))
    (when (executable-find "eslint")
      (progn
        (flycheck-select-checker 'javascript-eslint)
        (add-hook 'after-save-hook 'eslint-fix nil t)))))
  (when
      (some (lambda (type) (string= web-mode-content-type type)) '("css" "javascript" "json" "jsx"))
    (prettier-js-mode-enable)))

(add-hook 'web-mode-hook 'web-mode-setting)

(add-hook 'web-mode-hook 'flow-minor-enable-automatically)

(add-hook 'css-mode-hook 'prettier-js-mode-enable)
(add-hook 'json-mode-hook 'prettier-js-mode-enable)
(add-hook 'less-css-mode-hook 'prettier-js-mode-enable)
(add-hook 'scss-mode-hook 'prettier-js-mode-enable)
(add-hook 'typescript-mode-hook 'prettier-js-mode-enable)
(add-hook 'yaml-mode-hook 'prettier-js-mode-enable)

(add-hook 'typescript-mode-hook 'tide-setting)

(advice-add 'eslint-fix :after 'flycheck-buffer)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
