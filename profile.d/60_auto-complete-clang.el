(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (push 'ac-source-clang ac-sources)
  (push 'ac-source-yasnippet ac-sources)
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
