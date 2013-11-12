;;(setq dired-listing-switches "-hFAvlD");diredでソート順を設定
(defvar dired-listing-switches "-l --all --human-readable --almost-all -v");diredでソート順を設定

(autoload 'open-junk-file "open-junk-file");;使い捨てないscratch
(defvar open-junk-file-directory)
(setq open-junk-file-directory "~/Documents/log/%Y_%m/")

(require 'wdired)

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

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(defun dired-jump-to-current ()
  (interactive)
  (dired "."))
