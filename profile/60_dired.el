;; -*- lexical-binding: t -*-

(custom-set-variables
 '(dired-listing-switches "-Fhval --group-directories-first")      ;diredが使うlsオプションの設定
 )

(with-eval-after-load 'dired
  (defun dired-jump-to-current ()
    (interactive)
    (dired "."))

  (defun dired-disable-M-o()
    (define-key dired-mode-map (kbd "M-o") 'nil))

  (add-hook 'dired-mode-hook 'dired-disable-M-o)

  (ncaq-set-key dired-mode-map)
  (define-key dired-mode-map (kbd "C-^")     'dired-up-directory)
  (define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode)
  )
