(require 'helm-config)
(helm-mode 1)
(require 'helm)

(require 'helm-descbinds-autoloads)
(helm-descbinds-mode t)

;;デフォルトはファイル名を短縮する区切りが20
(require 'helm-buffers)
(setq helm-buffer-max-length 50)

;;flycheckとhelmの組み合わせバグに対する強引な回避方法
(require 'helm-files)
(eval-when-compile (require 'cl-lib))
(setq helm-source-recentf
      (cl-remove-if
       (lambda (x) (eq 'init (car x)));;'(init hogehoge) を取り除く
       helm-source-recentf))

;;デフォルトだとPrefixになる
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'backward-delete-char-untabify)
     ))
