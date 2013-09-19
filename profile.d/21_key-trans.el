;;EmacsのデフォルトのKeyindには特に意味はない
;;ユーザが勝手に設定することを前提としている…と思う

;;t,pの入れ替え
(global-set-key (kbd "t") (lambda () (interactive)(insert-char ?p)))
(define-key key-translation-map (kbd "t") (kbd "p"))
(define-key key-translation-map (kbd "C-t") (kbd "C-p"))
(define-key key-translation-map (kbd "M-t") (kbd "M-p"))
(define-key key-translation-map (kbd "C-M-t") (kbd "C-M-p"))
(define-key key-translation-map (kbd "C-S-t") (kbd "C-S-p"))

(global-set-key (kbd "p") (lambda () (interactive)(insert-char ?t)))
(define-key key-translation-map (kbd "p") (kbd "t"))
(define-key key-translation-map (kbd "C-p") (kbd "C-t"))
(define-key key-translation-map (kbd "M-p") (kbd "M-t"))
(define-key key-translation-map (kbd "C-M-p") (kbd "C-M-t"))
(define-key key-translation-map (kbd "C-S-p") (kbd "C-S-t"))

;;h,bの入れ替え
(global-set-key (kbd "h") (lambda () (interactive)(insert-char ?b)))
(define-key key-translation-map (kbd "h") (kbd "b"))
(define-key key-translation-map (kbd "C-h") (kbd "C-b"))
(define-key key-translation-map (kbd "M-h") (kbd "M-b"))
(define-key key-translation-map (kbd "C-M-h") (kbd "C-M-b"))
(define-key key-translation-map (kbd "C-S-h") (kbd "C-S-b"))

(global-set-key (kbd "b") (lambda () (interactive)(insert-char ?h)))
(define-key key-translation-map (kbd "b") (kbd "h"))
(define-key key-translation-map (kbd "C-b") (kbd "C-h"))
(define-key key-translation-map (kbd "M-b") (kbd "M-h"))
(define-key key-translation-map (kbd "C-M-b") (kbd "C-M-h"))
(define-key key-translation-map (kbd "C-S-b") (kbd "C-S-h"))

;;s,fの入れ替え
(global-set-key (kbd "s") (lambda () (interactive)(insert-char ?f)))
(define-key key-translation-map (kbd "s") (kbd "f"))
(define-key key-translation-map (kbd "C-s") (kbd "C-f"))
(define-key key-translation-map (kbd "M-s") (kbd "M-f"))
(define-key key-translation-map (kbd "C-M-s") (kbd "C-M-f"))
(define-key key-translation-map (kbd "C-S-s") (kbd "C-S-f"))

(global-set-key (kbd "f") (lambda () (interactive)(insert-char ?s)))
(define-key key-translation-map (kbd "f") (kbd "s"))
(define-key key-translation-map (kbd "C-f") (kbd "C-s"))
(define-key key-translation-map (kbd "M-f") (kbd "M-s"))
(define-key key-translation-map (kbd "C-M-f") (kbd "C-M-s"))
(define-key key-translation-map (kbd "C-S-f") (kbd "C-S-s"))

(add-hook 'isearch-mode-end-hook
	  (function
	   (lambda ()
	     (define-key key-translation-map (kbd "b") (kbd "h"))
	     (define-key key-translation-map (kbd "f") (kbd "s"))
	     (define-key key-translation-map (kbd "h") (kbd "b"))
	     (define-key key-translation-map (kbd "p") (kbd "t"))
	     (define-key key-translation-map (kbd "s") (kbd "f"))
	     (define-key key-translation-map (kbd "t") (kbd "p")))))

(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key key-translation-map (kbd "b") (kbd "b"))
	     (define-key key-translation-map (kbd "f") (kbd "f"))
	     (define-key key-translation-map (kbd "h") (kbd "h"))
	     (define-key key-translation-map (kbd "p") (kbd "p"))
	     (define-key key-translation-map (kbd "s") (kbd "s"))
	     (define-key key-translation-map (kbd "t") (kbd "t")))))
