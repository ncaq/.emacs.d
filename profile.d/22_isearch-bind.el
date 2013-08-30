;;C-hをBackSpaceに変更
(global-unset-key (kbd "C-h"))
(global-set-key (kbd "C-M-h")	'backward-kill-sentence)
(global-set-key (kbd "C-S-h")	'c-hungry-backspace)
(global-set-key (kbd "C-h")	'c-electric-backspace)
(global-set-key (kbd "M-h")	'backward-kill-word)
;;http://stackoverflow.com/questions/13897125/emacs-translating-c-h-to-del-m-h-to-m-del
;;検索上でも効くように
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
	     (define-key isearch-mode-map (kbd "M-h") 'isearch-del-char))));保留
