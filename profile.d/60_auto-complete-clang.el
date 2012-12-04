(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))
  (ac-cc-mode-setup)  
  )
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
