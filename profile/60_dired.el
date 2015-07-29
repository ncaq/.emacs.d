;; -*- lexical-binding: t -*-

(custom-set-variables
 '(dired-listing-switches "-Fhval --group-directories-first")      ;diredが使うlsオプションの設定
 )

(with-eval-after-load 'dired
  (defun dired-jump-to-current ()
    (interactive)
    (dired "."))

  (ncaq-set-key dired-mode-map)
  (define-key dired-mode-map (kbd "C-o") 'nil)
  (define-key dired-mode-map (kbd "C-p") 'nil)
  (define-key dired-mode-map (kbd "M-o") 'nil)
  (define-key dired-mode-map (kbd "C-^") 'dired-up-directory)
  (define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode)
  )
