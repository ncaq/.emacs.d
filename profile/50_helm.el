;; -*- lexical-binding: t -*-

(require 'helm-mode)
(require 'helm-config)

(helm-mode 1)
(helm-descbinds-mode 1)

(defvar helm-for-files-original-preferred-list helm-for-files-preferred-list)
(defvar helm-for-files-lite-preferred-list (remove 'helm-source-locate helm-for-files-preferred-list))

(defun helm-for-files-lite ()
  (interactive)
  (setq helm-for-files-preferred-list helm-for-files-lite-preferred-list)
  (helm-for-files)
  (setq helm-for-files-preferred-list helm-for-files-original-preferred-list)
  )

(custom-set-variables
 '(helm-boring-buffer-regexp-list (append '("\\*tramp" "\\*magit-process\\*") helm-boring-buffer-regexp-list))
 '(helm-buffer-max-len-mode 25)         ;モードを短縮する基準
 '(helm-buffer-max-length 50)           ;デフォルトはファイル名を短縮する区切りが20
 '(helm-samewindow t)                   ;ウインドウ全体に表示
 )

(define-key helm-buffer-map        (kbd "C-s") 'nil)
(define-key helm-generic-files-map (kbd "C-s") 'nil)
(define-key helm-map               (kbd "C-h") 'nil) ;デフォルトだとPrefixになる
(define-key helm-map               (kbd "C-s") 'nil)
(define-key helm-map               (kbd "C-t") 'helm-previous-line)
(define-key helm-map               (kbd "M-s") 'nil)
(define-key helm-read-file-map     (kbd "TAB") 'helm-execute-persistent-action)
