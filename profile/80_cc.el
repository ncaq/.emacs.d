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
                             (:exec    . ("%c -std=c99 -ggdb -Wall -Wextra %o -o %e %s"
                                          "%e %a"))
                             (:remove  . ("%e")))
                           :default "c")

     (quickrun-add-command "c++11/g++"
                           '((:command . "g++")
                             (:exec    . ("%c -std=c++11 -ggdb -Wall -Wextra %o -o %e %s"
                                          "%e %a"))
                             (:remove  . ("%e")))
                           :default "c++")
     ))

(eval-after-load 'gud
  '(progn
     (custom-set-variables
      '(gdb-many-windows t)        ;情報表示
      '(gud-tooltip-echo-area t)   ;mini bufferに値を表示
      '(gud-tooltip-mode t)        ;ポップアップで情報
      )
     (define-key gud-minor-mode-map (kbd "<f7>")  'gud-until)  ;現在の行まで実行
     (define-key gud-minor-mode-map (kbd "<f8>")  'gud-cont)   ;ブレークポイントに会うまで実行
     (define-key gud-minor-mode-map (kbd "<f9>")  'gud-break)  ;ブレークポイント設置
     (define-key gud-minor-mode-map (kbd "<f10>") 'gud-next)   ;1行進む
     (define-key gud-minor-mode-map (kbd "<f11>") 'gud-step)   ;1行進む.関数に入る
     (define-key gud-minor-mode-map (kbd "<f12>") 'gud-finish) ;step out 現在のスタックフレームを抜ける
     ))

(with-eval-after-load 'smartparens
  ;; based on https://github.com/Fuco1/smartparens/wiki/Permissions
  (defun my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (forward-line -1)
    (indent-according-to-mode)
    (forward-line 1)
    (indent-according-to-mode)
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode)
    )

  (sp-local-pair 'c++-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  )

(eval-after-load 'cc-mode
  '(progn
     (define-key c-mode-base-map (kbd "C-M-h") nil)
     ))
