(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

;;auto-complete-config.el:501行の関数の再定義 先頭にac-source-clangを入れなければならないことを考えるとこの選択肢しか無い
(defun ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet ac-source-gtags) ac-sources)))

(defun set-clang-flag ()
  (setq ac-clang-flags '(
			 ;; "-w"
			 "-std=c++11"
					;汎用
			 "-I/usr/include"
			 		;Gtkmm
			 ;; "`pkg-config --cflags-only-I gtkmm-utils`"
					;GLUT
			 "-I/usr/include/GL"
			 "-I/usr/include/GL/internal"
			 )))
(add-hook 'c++-mode-hook 'set-clang-flag)
