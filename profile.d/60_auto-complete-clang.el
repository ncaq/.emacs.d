(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (add-to-list 'ac-sources '(ac-source-clang . ac-source-yasnippet))
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
