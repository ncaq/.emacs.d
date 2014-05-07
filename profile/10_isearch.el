(defun isearch-exit-previous ()
  "通常isearchは終了するとき,マッチした文字列の末尾に移動するが,これは先頭に移動する."
  (interactive)
  (let ((found-string-length (length isearch-string))
	(forward isearch-forward))
    (progn
      (isearch-exit)
      (goto-char (if forward
		     (-(point) found-string-length)
		   (+(point) found-string-length))))))

(define-key isearch-mode-map (kbd "C-b") 'isearch-delete-char)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-s") nil)
(define-key isearch-mode-map (kbd "M-b") 'isearc-del-char)
(define-key isearch-mode-map (kbd "M-m") 'isearch-exit-previous)