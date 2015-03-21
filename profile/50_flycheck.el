;; -*- lexical-binding: t -*-

(with-eval-after-load 'flycheck
  (global-flycheck-mode 1)
  
  (custom-set-variables
   '(flycheck-display-errors-function nil) ; Echoエリアにエラーを表示しない
   '(flycheck-highlighting-mode nil)    ; 下線があると_が見えなくなる
   '(flycheck-idle-change-delay 5)      ; 5秒
   '(flycheck-indication-mode 'left-fringe)
   )

  (define-key flycheck-mode-map (kbd "C-,") 'helm-flycheck)
  (define-key flycheck-mode-map (kbd "C-c ,") 'flycheck-list-errors)
  )
