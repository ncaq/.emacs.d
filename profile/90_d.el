;; -*- lexical-binding: t -*-

(with-eval-after-load 'd-mode
  (custom-set-variables '(c-default-style (cons '(d-mode . "java") c-default-style)))
  (defun dfmt-save-buffer-force ()
    "セーブした後dfmt-bufferする.
dfmt-bufferを先にしたりbefore-save-hookを使ったりすると
保存がキャンセルされてflycheckの恩恵を受けられない
"
    (interactive)
    (save-buffer)
    (dfmt-buffer)
    (when (buffer-modified-p) (save-buffer)))
  (define-key d-mode-map [remap indent-whole-buffer] 'dfmt-region-or-buffer)
  (define-key d-mode-map [remap save-buffer] 'dfmt-save-buffer-force)
  )
