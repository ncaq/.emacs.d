;; -*- lexical-binding: t -*-

(require 'helm-config)

(helm-mode 1)

(custom-set-variables
 '(helm-boring-buffer-regexp-list (append '("\\*tramp" "\\*magit") helm-boring-buffer-regexp-list))
 '(helm-buffer-max-len-mode 25)                  ;モードを短縮する基準
 '(helm-buffer-max-length 50)                    ;デフォルトはファイル名を短縮する区切りが20
 '(helm-delete-minibuffer-contents-from-point t) ;kill-line sim
 '(helm-descbinds-mode t)
 '(helm-samewindow t)                            ;ウインドウ全体に表示
 )

(swap-set-key helm-map '(("C-t" . "C-p")
                         ("C-s" . "C-f")))

(define-key helm-buffer-map        (kbd "C-s")   'nil)
(define-key helm-find-files-map    (kbd "C-s")   'nil)
(define-key helm-generic-files-map (kbd "C-s")   'nil)
(define-key helm-map               (kbd "C-M-b") 'nil)
(define-key helm-map               (kbd "C-h")   'nil)
(define-key helm-map               (kbd "M-b")   'nil)
(define-key helm-map               (kbd "M-s")   'nil)

(define-key helm-map (kbd "<tab>") 'helm-select-action)
(define-key helm-map (kbd "C-b") 'backward-delete-char-untabify)
