;; -*- lexical-binding: t -*-

(with-eval-after-load 'd-mode
  (custom-set-variables
   '(c-default-style (cons '(d-mode . "java") c-default-style))
   '(dfmt-flags '("--max_line_length=80"))
   )
  (defun save-buffer-and-dfmt ()
    "セーブした後dfmt-bufferする.
dfmt-bufferを先にしたりbefore-save-hookを使ったりすると
保存がキャンセルされてflycheckの恩恵を受けられない
"
    (interactive)
    (when (buffer-modified-p)
      (save-buffer)
      (when (and (dfmt-buffer) (buffer-modified-p)) (save-buffer))))
  (define-key d-mode-map [remap indent-whole-buffer] 'dfmt-region-or-buffer)
  (define-key d-mode-map [remap save-buffer] 'save-buffer-and-dfmt)
  )
