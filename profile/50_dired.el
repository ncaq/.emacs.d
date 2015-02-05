;; -*- lexical-binding: t -*-

(require 'dired)

(custom-set-variables
 '(insert-directory-program "ls-first-ln-dir") ;lsコマンド指定
 '(dired-listing-switches "-alFh")      ;diredが使うlsオプションの設定
 )

(defun dired-jump-to-current ()
  (interactive)
  (dired "."))

(defun dired-disable-M-o()
  (define-key dired-mode-map (kbd "M-o") 'nil))

(add-hook 'dired-mode-hook 'dired-disable-M-o)
(define-key dired-mode-map (kbd "C-^")     'dired-up-directory)
(define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "C-o")     'nil)
(define-key dired-mode-map (kbd "C-t")     'nil)
(define-key dired-mode-map (kbd "M-s")     'nil)
(define-key dired-mode-map (kbd "p")       'dired-toggle-marks)
(define-key dired-mode-map (kbd "t")       'dired-previous-line)
