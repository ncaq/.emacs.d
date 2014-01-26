(require 'cc-mode)
(require 'flycheck)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く

(add-hook 'c-mode-hook (lambda ()
			 (setq flycheck-clang-language-standard "c11")))

(add-hook 'c++-mode-hook (lambda ()
			   (setq flycheck-clang-language-standard "c++11")))

(require 'c-eldoc)
(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)

(defun ncaq-c++ ()
  (c-set-style "bsd")
  (define-key c-mode-base-map [remap indent-whole-buffer] 'indent-brackets-whole-buffer))
(add-hook 'c-mode-common-hook 'ncaq-c++)
