(require 'cc-mode)
(require 'flycheck-autoloads)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く

(add-hook 'c-mode-hook (lambda ()
			 (custom-set-variables '(flycheck-clang-language-standard "c11"))))

(add-hook 'c++-mode-hook (lambda ()
			   (custom-set-variables '(flycheck-clang-language-standard "c++1y"))))

(require 'c-eldoc-autoloads)
(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)

(custom-set-variables '(c-default-style
			'((c-mode . "bsd")
			  (c++-mode . "bsd")
			  (java-mode . "java")
			  (awk-mode . "awk")
			  (other . "bsd"))))

(define-key c-mode-base-map [remap indent-whole-buffer] 'indent-brackets-whole-buffer)
