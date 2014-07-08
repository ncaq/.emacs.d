;; -*- lexical-binding: t -*-
(require 'helm-mode)
(require 'helm-config)
(helm-mode 1)

;;helmを無効にするコマンドリスト
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
(add-to-list 'helm-completing-read-handlers-alist '(find-file-at-point . nil))

(custom-set-variables
 '(helm-samewindow t);ウインドウ全体に表示
 '(helm-buffer-max-length 50));デフォルトはファイル名を短縮する区切りが20
(setq helm-exit-idle-delay 0.1)

(require 'helm-descbinds)
(helm-descbinds-mode 1)

(define-key helm-buffer-map (kbd "C-s") nil)
(define-key helm-generic-files-map (kbd "C-s") nil)
(define-key helm-map (kbd "C-h") nil);デフォルトだとPrefixになる
(define-key helm-map (kbd "C-s") nil)
(define-key helm-map (kbd "C-t") 'helm-previous-line)
(define-key helm-map (kbd "M-s") nil)