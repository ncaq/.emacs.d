(setq dired-listing-switches "-AFhvl");diredが使うlsオプションの設定

;;atoolの設定
;;http://d.hatena.ne.jp/mooz/20110911/p1
(defvar my-dired-additional-compression-suffixes
  '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio"
    ".deb" ".gz" ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar"
    ".rpm" ".rz" ".t7z" ".tZ" ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz"
    ".tzo" ".war" ".xz" ".zip"))
(eval-after-load "dired-aux"
  '(progn
     (require 'cl)
     (loop for suffix in my-dired-additional-compression-suffixes
           do (add-to-list 'dired-compress-file-suffixes
                           `(,(concat "\\" suffix "\\'") "" "aunpack")))))

(defun dired-jump-to-current ()
  (interactive)
  (dired "."))

;;実行ファイルに色を付ける
(defface face-for-executable '((t :foreground "#5f8700")) nil)
(defvar  face-for-executable 'face-for-executable)

(eval-after-load "dired"
  '(add-to-list
    'dired-font-lock-keywords
    (list dired-re-exe
	  '(".+" (dired-move-to-filename) nil (0 'face-for-executable)))))

(define-key dired-mode-map (kbd "C-^") 'dired-up-directory)
