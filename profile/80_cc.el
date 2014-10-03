;; -*- lexical-binding: t -*-

(custom-set-variables '(c-default-style
                        '((c-mode . "bsd")
                          (c++-mode . "bsd")
                          (java-mode . "java")
                          (awk-mode . "awk")
                          (other . "bsd"))))

(eval-after-load 'flycheck
  '(progn
     (defun flycheck-select-c-checker ()
       (custom-set-variables
        '(flycheck-clang-language-standard "c99")))
     (add-hook 'c-mode-hook 'flycheck-select-c-checker)

     (defun flycheck-select-cc-checker ()
       (custom-set-variables
        '(flycheck-clang-language-standard "c++11")
        '(flycheck-clang-standard-library "libc++")
        '(flycheck-clang-include-path '("/usr/include/c++/v1"))
        ))
     (add-hook 'c++-mode-hook 'flycheck-select-cc-checker)
     ))

(eval-after-load 'quickrun
  '(progn
     (quickrun-add-command "c99/gcc"
                           '((:command . "gcc")
                             (:exec    . ("%c -std=c99 -g -Werror -Wall -Wextra %o -o %e %s"
                                          "%e %a"))
                             (:remove  . ("%e")))
                           :default "c")

     (quickrun-add-command "c++11/g++"
                           '((:command . "g++")
                             (:exec    . ("%c -std=c++11 -g -Werror -Wall -Wextra %o -o %e %s"
                                          "%e %a"))
                             (:remove  . ("%e")))
                           :default "c++")
     ))

(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "C-M-h") nil)
    ))
