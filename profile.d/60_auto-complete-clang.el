(require 'auto-complete-clang)

;;auto-complete-config.el:501行の関数の再定義 先頭にac-source-clangを入れなければならないことを考えるとこの選択肢しか無い
(defun ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet ac-source-gtags) ac-sources)))

(defun set-clang-flag ()
  (setq ac-clang-flags '(
					;汎用
			 "-std=c++11"
			 		;Gtkmm
					;"`pkg-config --cflags-only-I gtkmm-utils`"
					;GLUT
			 "-I/usr/include/GL/"
			 "-I/usr/include/GL/internal/"
			 )))
(add-hook 'c++-mode-hook 'set-clang-flag)
