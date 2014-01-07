(defun isearch-exit-previous ()
  "通常isearchは終了するとき,マッチした文字列の末尾に移動するが,これは先頭に移動する."
  (interactive)
  (let ((found-string-length (length isearch-string)))
    (progn
      (isearch-exit)
      (goto-char (- (point) found-string-length)))))

(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
(define-key isearch-mode-map (kbd "M-h") 'isearch-del-char)
(define-key isearch-mode-map (kbd "M-m") 'isearch-exit-previous)
