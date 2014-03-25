(require 'helm-mode)
(helm-mode)
;;helmを無効にする関数リストe
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

(require 'helm-descbinds-autoloads)
(helm-descbinds-mode)

;;デフォルトはファイル名を短縮する区切りが20
;; (require 'helm-buffers)
;; (setq helm-buffer-max-length 10)

;;デフォルトだとPrefixになる
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") nil)
     ))
