;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; set load-path
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list (concat user-emacs-directory "mine/")))

(require 'init-loader)
(custom-set-variables '(init-loader-show-log-after-init nil))
(init-loader-load (concat user-emacs-directory "profile/"))
