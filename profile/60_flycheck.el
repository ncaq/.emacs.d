;; -*- lexical-binding: t -*-
;;http://d.hatena.ne.jp/kitokitoki/20101230
(require 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(custom-set-variables
 '(flycheck-highlighting-mode 'nil);下線があると,_が見えなくなる
 '(flycheck-check-syntax-automatically '(mode-enabled save));セーブした時だけにチェック
 '(flycheck-display-errors-function 'nil);;Echoエリアにエラーを表示しない
 '(flycheck-indication-mode 'left-fringe))
