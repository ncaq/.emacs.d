(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet ac-source-gtags) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
