;; -*- lexical-binding: t -*-

(require 'generic-x)

(add-to-list 'auto-mode-alist '("\\.accept_keywords$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.keywords$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.license$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.mask$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.unmask$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.use$" . conf-space-mode))

(add-to-list 'auto-mode-alist '("\\.ssh/config$" . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config$" . ssh-config-mode))

(add-to-list 'auto-mode-alist '("\\.jsx$" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
