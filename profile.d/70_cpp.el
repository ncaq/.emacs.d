(require 'cc-mode)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く

(require 'flycheck-autoloads)

(add-hook 'c-mode-hook (lambda ()
			 (custom-set-variables '(flycheck-clang-language-standard "c11"))))

(add-hook 'c++-mode-hook (lambda ()
			   (custom-set-variables '(flycheck-clang-language-standard "c++1y"))))

(custom-set-variables '(flycheck-clang-standard-library "libc++")
		      '(flycheck-clang-include-path ("/usr/include/c++/v1")))

;; (add-hook 'c++-mode-hook (lambda ()
;; 			   (custom-set-variables '(quickrun-option-args "-std=c++1y -stdlib=libc++"))))

(require 'c-eldoc-autoloads)
(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)

(custom-set-variables '(c-default-style
			'((c-mode . "bsd")
			  (c++-mode . "bsd")
			  (java-mode . "java")
			  (awk-mode . "awk")
			  (other . "bsd"))))

(define-key c-mode-base-map [remap indent-whole-buffer] 'indent-brackets-whole-buffer)
