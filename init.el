;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; set load-path
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list (concat user-emacs-directory "mine/")))

(require 'init-loader)
(init-loader-load (concat user-emacs-directory "profile/"))
