;; -*- lexical-binding: t -*-
(require 'helm-mode)
(require 'helm-config)
(helm-mode 1)

;;helmを無効にするコマンドリスト
(add-to-list 'helm-completing-read-handlers-alist 'find-file)
(add-to-list 'helm-completing-read-handlers-alist 'find-file-at-point)

(custom-set-variables
 '(helm-samewindow t);今のウインドウに表示
 '(helm-buffer-max-length 50));デフォルトはファイル名を短縮する区切りが20

(require 'helm-descbinds)
(helm-descbinds-mode 1)

(define-key helm-map (kbd "C-h") nil);デフォルトだとPrefixになる
(define-key helm-map (kbd "C-s") nil)
(define-key helm-map (kbd "C-t") 'helm-previous-line)
