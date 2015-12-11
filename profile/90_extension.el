;; -*- lexical-binding: t -*-

(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t) ;http://www.okada.jp.org/RWiki/?ESS

(add-to-list 'auto-mode-alist '("\\.R\\'"          . R-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"        . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.license\\'"    . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.r\\'"          . R-mode))
(add-to-list 'auto-mode-alist '("\\.ssh/config\\'" . ssh-config-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'"        . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'"        . shell-script-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'"  . ssh-config-mode))

(require 'generic-x)
