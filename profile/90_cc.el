;; -*- lexical-binding: t -*-

(custom-set-variables
 '(c-default-style
   '((c-mode . "bsd")
     (c++-mode . "bsd")
     (java-mode . "bsd")
     (awk-mode . "awk")
     (other . "bsd")))
 '(c-basic-offset 4)
 '(flycheck-clang-language-standard "c++14")
 )

(with-eval-after-load 'cc-mode (ncaq-set-key c-mode-base-map))
