;; -*- lexical-binding: t -*-

(with-eval-after-load 'lsp-mode
  (custom-set-variables '(lsp-prefer-flymake nil)) ; flycheckを優先する

  (define-key lsp-mode-map (kbd "C-c C-e") 'lsp-workspace-restart)
  (define-key lsp-mode-map (kbd "C-c C-i") 'lsp-format-buffer)
  (define-key lsp-mode-map (kbd "C-c C-n") 'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c C-r") 'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c C-t") 'lsp-describe-thing-at-point)
  )

;; 普通はアイドル時に自動でしかポップアップしないものを手動のキーバウンドで出す
(defun lsp-ui-doc-show-manual ()
  (interactive)
  (lsp-ui-doc--display
   (thing-at-point 'symbol t)
   (lsp-ui-doc--extract (gethash "contents" (lsp-request "textDocument/hover" (lsp--text-document-position-params))))))

(with-eval-after-load 'lsp-ui-doc
  (custom-set-variables '(lsp-ui-doc-delay 2)) ; 初期値の0.2はせわしなさすぎる

  (define-key lsp-mode-map (kbd "C-c C-d") 'lsp-ui-doc-show-manual)
  )
