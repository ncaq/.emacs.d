;; -*- lexical-binding: t -*-

(custom-set-variables
 '(gc-cons-percentage (* gc-cons-percentage 5))
 '(gc-cons-threshold (* gc-cons-threshold 5))
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; set load-path
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list (concat user-emacs-directory "module/")))

(require 'init-loader)
(init-loader-load (concat user-emacs-directory "profile/"))
