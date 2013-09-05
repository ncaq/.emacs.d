;;http://stackoverflow.com/questions/13897125/emacs-translating-c-h-to-del-m-h-to-m-del
;;検索上でも効くように
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
	     (define-key isearch-mode-map (kbd "M-h") 'isearch-del-char))));保留

;;helmはPrefix設定になる
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ))
