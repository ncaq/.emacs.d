(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun add-source-clang ()
  (add-to-list 'ac-sources '(ac-source-clang))
  )

(add-hook 'c-mode-common-hook 'add-source-clang)
