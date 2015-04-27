;; -*- lexical-binding: t -*-

(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t) ;http://www.okada.jp.org/RWiki/?ESS

(add-to-list 'auto-mode-alist '("\\.R\\'"          . R-mode))
(add-to-list 'auto-mode-alist '("\\.license\\'"    . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mask\\'"       . conf-mode))
(add-to-list 'auto-mode-alist '("\\.r\\'"          . R-mode))
(add-to-list 'auto-mode-alist '("\\.ssh/config\\'" . ssh-config-mode))
(add-to-list 'auto-mode-alist '("\\.unmask\\'"     . conf-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'"        . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'"        . shell-script-mode))
(add-to-list 'auto-mode-alist '("nginx.conf\\'"    . nginx-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'"  . ssh-config-mode))

(custom-set-variables
 '(scheme-program-name "gosh")
 '(scss-sass-options '("--cache-location" "'/tmp/.sass-cache/'" "--style" "expanded"))
 )
