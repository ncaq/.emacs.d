;; -*- lexical-binding: t -*-

(require 'helm-mode)
(helm-mode 1)
(helm-descbinds-mode 1)

(custom-set-variables
 '(helm-boring-buffer-regexp-list '("\\*"))
 '(helm-buffer-max-length 50) ;デフォルトはファイル名を短縮する区切りが20
 '(helm-samewindow t);ウインドウ全体に表示
 )

(defun helm-buffers-list-selective ()
  (interactive)
  (setq helm-boring-buffer-regexp-list '("\\*"))
  (helm-buffers-list))

(defun helm-for-files-list-other-helm ()
  (interactive)
  (setq helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*Echo Area" "\\*Minibuf" "\\*tramp"))
  (helm-for-files))

(define-key helm-buffer-map        (kbd "C-s") 'nil)
(define-key helm-generic-files-map (kbd "C-s") 'nil)
(define-key helm-map               (kbd "C-h") 'nil) ;デフォルトだとPrefixになる
(define-key helm-map               (kbd "C-s") 'nil)
(define-key helm-map               (kbd "C-t") 'helm-previous-line)
(define-key helm-map               (kbd "M-s") 'nil)
(define-key helm-read-file-map     (kbd "TAB") 'helm-execute-persistent-action)
