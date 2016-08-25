;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.jsx\\'"        . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.license\\'"    . conf-mode))
(add-to-list 'auto-mode-alist '("\\.ssh/config\\'" . ssh-config-mode))
(add-to-list 'auto-mode-alist '("\\.use\\'"        . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'"        . shell-script-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'"  . ssh-config-mode))

(require 'generic-x)
