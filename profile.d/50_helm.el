(require 'helm-config)
(require 'helm-mode)
(helm-mode)

(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil));helmを無効にする関数リスト
(custom-set-variables '(helm-samewindow t);今のウインドウに表示
                      '(helm-buffer-max-length 50));デフォルトはファイル名を短縮する区切りが20

(require 'helm-descbinds)
(helm-descbinds-mode)

(define-key helm-map (kbd "C-h") nil);デフォルトだとPrefixになる
(define-key helm-map (kbd "C-s") nil)
(define-key helm-map (kbd "C-t") 'helm-previous-line)
