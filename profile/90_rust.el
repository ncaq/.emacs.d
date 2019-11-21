;; -*- lexical-binding: t -*-

;; rust-modeで開かれる時があるのでrustic-modeを末尾に追加し直す
(cl-delete-if (lambda (element) (equal (cdr element) 'rust-mode)) auto-mode-alist)
(cl-delete-if (lambda (element) (equal (cdr element) 'rustic-mode)) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))

;; 本当にwithout switchしているわけではなく前のウィンドウにフォーカスを戻すだけ
(defun pop-to-buffer-without-switch (buffer-or-name &optional action norecord)
  (pop-to-buffer buffer-or-name action norecord)
  (other-window -1)
  )

(custom-set-variables
 ;; エラーポップアップにフォーカスを移さない
 '(rustic-format-display-method 'pop-to-buffer-without-switch)
 ;; 保存時にrustfmtを動かす
 '(rustic-format-on-save t)
 )

;; rusticの場合のみlspではなくrustic特有のflycheckを使う
;; clippyが見えるようになるので
(defun flycheck-select-checker-rustic ()
  (flycheck-select-checker 'rustic-clippy))
(add-hook 'rustic-mode-hook 'flycheck-select-checker-rustic)
