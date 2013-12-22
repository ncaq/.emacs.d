(require 'helm-config)
(helm-mode 1)
(require 'helm)

(require 'helm-ag-autoloads)
(require 'helm-flymake-autoloads)
(require 'helm-gist-autoloads)
(require 'helm-git-autoloads)
(require 'helm-gtags-autoloads)
(require 'helm-ls-git-autoloads)

(require 'helm-descbinds-autoloads)
(helm-descbinds-mode t)

;;デフォルトだとPrefixになる
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'backward-delete-char-untabify)
     ))

;;デフォルトはファイル名を短縮する区切りが20
(require 'helm-buffers)
(setq helm-buffer-max-length 50)

(require 'helm-files)
(require 'helm-locate)
;;flycheckとhelmの組み合わせバグに対する強引な回避方法
(setq helm-source-recentf
      `((name . "Recentf")
	(candidates . recentf-list)
	(match . helm-files-match-only-basename)
	(filtered-candidate-transformer . (lambda (candidates _source)
					    (loop for i in candidates
						  if helm-ff-transformer-show-only-basename
						  collect (cons (helm-basename i) i)
						  else collect i)))
	(no-delay-on-input)
	(keymap . ,helm-generic-files-map)
	(help-message . helm-generic-file-help-message)
	(mode-line . helm-generic-file-mode-line-string)
	(action . ,(cdr (helm-get-actions-from-type
			 helm-source-locate)))))

