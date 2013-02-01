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
			 ;; 		;Qt用
			 ;; "-I/usr/include/qt4/QtCore" "-I/usr/include/qt4/QtGui" "-I/usr/include/qt4"
			 ;; "-DQT_WEBKIT" "-DQT_NO_DEBUG" "-DQT_GUI_LIB" "-DQT_CORE_LIB" "-DQT_SHARED"
			 ;; 		;SDL用
			 ;; "-I/usr/include/SDL"
			 ;; "-I/usr/include/png12"
			 ;; 		;Gtkmm
					;GLUT
			 "-I/usr/include/GL"
			 )))
(add-hook 'c++-mode-hook 'set-clang-flag)

