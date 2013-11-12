;;https://pqrs. org/emacs/doc/keyjack-mode/
(defvar keyjack-mode-map (make-sparse-keymap))

(mapc (lambda (x)
	(define-key keyjack-mode-map (funcall (car(car x))(car(cdr(car x)))) (cdr x));;これはひどい…括弧の山だ…cadrとか使ったらもうちょっとマシになるのかな
	(global-set-key (funcall (car(car x))(car(cdr(car x)))) (cdr x)))
      '(
	
	((kbd "C-,")		. helm-for-files);C-xC-bは頻繁に打つにしてはめんどくさい
	((kbd "C-M-S-q")	. close-all-buffers);バッファを全て閉じる. まともに動かなくなるのですぐに終了すること
	((kbd "C-M-n")		. scroll-up-1)
	((kbd "C-M-p")		. scroll-down-1)
	((kbd "C-M-q")		. kill-buffer);バッファ閉じる
	((kbd "C-q")		. kill-buffer-and-window);バッファとウインドウ閉じる
	((kbd "C-t")		. other-window)
	
	))

(easy-mmode-define-minor-mode keyjack-mode "Grab keys" t " Keyjack" keyjack-mode-map)
