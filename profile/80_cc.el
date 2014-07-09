;; -*- lexical-binding: t -*-
(custom-set-variables '(c-default-style
                        '((c-mode . "bsd")
                          (c++-mode . "bsd")
                          (java-mode . "java")
                          (awk-mode . "awk")
                          (other . "bsd"))))

(require 'flycheck)
(add-hook 'c-mode-hook (lambda ()
                         (setq flycheck-clang-language-standard "c99")))
(add-hook 'c++-mode-hook (lambda ()
                           (setq flycheck-clang-language-standard "c++1y")
                           (setq flycheck-clang-standard-library "libc++")
                           (setq flycheck-clang-include-path '("/usr/include/c++/v1"))))

(require 'quickrun)
(quickrun-add-command "c99/clang"
                      '((:command . "clang")
                        (:exec    . ("%c -std=c99 -O0 -g -Wall -Werror %o -o %e %s"
                                     "%e %a"))
                        (:remove  . ("%e")))
                      :default "c")
(quickrun-add-command "c++1y/clang++"
                      '((:command . "clang++")
                        (:exec    . ("%c -std=c++1y -stdlib=libc++ -O0 -g -Wall -Werror %o -o %e %s"
                                     "%e %a"))
                        (:remove  . ("%e")))
                      :default "c++")

(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)