;; -*- lexical-binding: t -*-

(custom-set-variables
 '(global-flycheck-mode t)
 '(flycheck-check-syntax-automatically '(mode-enabled save)) ;セーブした時だけにリロード
 '(flycheck-display-errors-function nil)                     ;Echoエリアにエラーを表示しない
 '(flycheck-highlighting-mode nil)                           ;下線があると_が見えなくなる
 '(flycheck-idle-change-delay 5)                             ;5秒
 '(flycheck-indication-mode 'left-fringe)
 )

(with-eval-after-load 'flycheck
  (define-key flycheck-mode-map (kbd "C-j") 'flycheck-list-errors)
  (define-key flycheck-mode-map [remap previous-error] 'flycheck-previous-error)
  (define-key flycheck-mode-map [remap next-error] 'flycheck-next-error)
  )
