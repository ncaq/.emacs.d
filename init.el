;; -*- lexical-binding: t -*-

(custom-set-variables
 ;; gcの起動条件を緩くしてメモリを犠牲にパフォーマンスを向上
 '(gc-cons-percentage (* gc-cons-percentage 5))
 '(gc-cons-threshold (* gc-cons-threshold 5))
 ;; 再帰回数の制限緩くしてフリーズの危険性を犠牲にエラー落ちを減らす
 '(max-lisp-eval-depth (* max-lisp-eval-depth 20))
 '(max-specpdl-size (* max-specpdl-size 20))
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
