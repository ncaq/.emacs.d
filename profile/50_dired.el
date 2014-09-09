;; -*- lexical-binding: t -*-
(setq dired-listing-switches "-lAFhvX --group-directories-first");diredが使うlsオプションの設定

;;atoolの設定
;;http://d.hatena.ne.jp/mooz/20110911/p1
(defvar my-dired-additional-compression-suffixes
  '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio"
    ".deb" ".gz" ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar"
    ".rpm" ".rz" ".t7z" ".tZ" ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz"
    ".tzo" ".war" ".xz" ".zip"))
(eval-after-load "dired-aux"
  '(progn
     (loop for suffix in my-dired-additional-compression-suffixes
           do (add-to-list 'dired-compress-file-suffixes
                           `(,(concat "\\" suffix "\\'") "" "aunpack")))))

(require 'dired-sort)
(add-hook 'dired-mode-hook '(lambda ()
                              (define-key dired-mode-map "s" 'dired-various-sort-change-or-edit)
                              (define-key dired-mode-map "c" '(lambda ()
                                                                (interactive)
                                                                (helm '(helm-c-source-dired-various-sort))))))

(defun dired-jump-to-current ()
  (interactive)
  (dired "."))

(define-key dired-mode-map (kbd "C-^")     'dired-up-directory)
(define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "C-o")     'nil)
(define-key dired-mode-map (kbd "C-t")     'nil)
(define-key dired-mode-map (kbd "M-s")     'nil)
(add-hook 'dired-mode-hook (lambda ()(define-key dired-mode-map (kbd "M-o") nil)))
