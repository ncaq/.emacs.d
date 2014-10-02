;; -*- lexical-binding: t -*-

(eval-after-load 'flycheck
  '(progn
     (global-flycheck-mode 1)
     
     (custom-set-variables
      '(flycheck-display-errors-function nil)                     ;Echoエリアにエラーを表示しない
      '(flycheck-highlighting-mode nil)                           ;下線があると,_が見えなくなる
      '(flycheck-idle-change-delay 5)                             ;5秒
      '(flycheck-indication-mode 'left-fringe)
      )

     (require 'helm-flycheck)
     (define-key flycheck-mode-map (kbd "C-,") 'helm-flycheck)
     ))
