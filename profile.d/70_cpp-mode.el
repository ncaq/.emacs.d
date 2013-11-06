(require 'cc-mode)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く

(require 'flycheck)

(defun ncaq-c++-mode-set ()
  (c-set-style "bsd");http://www.02.246.ne.jp/~torutk/cxx/emacs/indentation.html
  (local-set-key (kbd "M-z") 'code-format-c))
(add-hook 'c-mode-common-hook 'ncaq-c++-mode-set)

(add-hook 'c-mode-hook (lambda ()
			 (setq flycheck-clang-language-standard "c11")))

(add-hook 'c++-mode-hook (lambda ()
			   (setq flycheck-clang-language-standard "c++11")))
