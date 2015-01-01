; -*- lexical-binding: t -*-

(require 'dired)

(custom-set-variables '(dired-listing-switches "-lAFhvL --group-directories-first")) ;diredが使うlsオプションの設定

;;atoolの設定
;;http://d.hatena.ne.jp/mooz/20110911/p1
(defvar my-dired-additional-compression-suffixes
  '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio"
    ".deb" ".gz" ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar"
    ".rpm" ".rz" ".t7z" ".tZ" ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz"
    ".tzo" ".war" ".xz" ".zip"))
(with-eval-after-load 'dired-aux
  '(progn
     (cl-loop for suffix in my-dired-additional-compression-suffixes
           do (add-to-list 'dired-compress-file-suffixes
                           `(,(concat "\\" suffix "\\'") "" "aunpack")))))

(defun helm-dired-various ()
  (interactive)
  (helm '(helm-c-source-dired-various-sort)))

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
(define-key dired-mode-map (kbd "t")       'dired-previous-line)
