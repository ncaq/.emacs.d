;; -*- lexical-binding: t -*-

(custom-set-variables '(dired-listing-switches "-Fhval --group-directories-first")) ;diredが使うlsオプションの設定

(with-eval-after-load 'dired
  (defun dired-jump-to-current ()
    (interactive)
    (dired "."))

  (defun dired-disable-M-o()
    (define-key dired-mode-map (kbd "M-o") 'nil))

  (add-hook 'dired-mode-hook 'dired-disable-M-o)
  (define-key dired-mode-map (kbd "C-^")     'dired-up-directory)
  (define-key dired-mode-map (kbd "C-c C-c") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "C-o")     'nil)
  (define-key dired-mode-map (kbd "C-t")     'nil)
  )
