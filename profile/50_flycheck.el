;; -*- lexical-binding: t -*-
(require 'flycheck)
(require 'helm-flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(custom-set-variables
 '(flycheck-check-syntax-automatically '(mode-enabled save)) ;セーブした時だけにリロード
 '(flycheck-display-errors-function nil)                     ;Echoエリアにエラーを表示しない
 '(flycheck-highlighting-mode nil)                           ;下線があると,_が見えなくなる
 '(flycheck-indication-mode 'left-fringe))

(define-key flycheck-mode-map (kbd "C-,") 'helm-flycheck)
