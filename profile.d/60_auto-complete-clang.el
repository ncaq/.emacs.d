;;d-mode confrict
;; (require 'auto-complete-clang)

;; ;;auto-complete-config.el:501行の関数の再定義 先頭にac-source-clangを入れなければならないことを考えるとこの選択肢しか無い
;; (defun ac-cc-mode-setup ()
;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet ac-source-gtags) ac-sources)))

;; (defun set-clang-flag ()
;;   (setq ac-clang-flags '(
;; 					;汎用
;; 			 "-std=c++11"
;; 			 "-stdlib=libc++"
;; 			 "-v"
;; 			 "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/include/g++-v4"
;; 			 "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/include/g++-v4/x86_64-pc-linux-gnu"
;; 			 "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/include/g++-v4/backward"
;; 			 "-I/usr/lib/clang/3.2/include"
;; 			 "-I/usr/include"
;; 			 		;Gtkmm
;; 					;"`pkg-config --cflags-only-I gtkmm-utils`"
;; 					;GLUT
;; 			 "-I/usr/include/GL/"
;; 			 "-I/usr/include/GL/internal/"
;; 			 )))
;; (add-hook 'c++-mode-hook 'set-clang-flag)
