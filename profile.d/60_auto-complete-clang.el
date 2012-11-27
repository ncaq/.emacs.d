(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete-clang/")
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (define-key c-mode-base-map "\M-\\" 'ac-complete-clang)
  (ac-cc-mode-setup)

  ;; (defun my-ac-cc-mode-setup ()
  ;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))
  ;;   (setq ac-clang-prefix-header "/プリコンパイル済みヘッダの場所/stdafx.pch")
  )
