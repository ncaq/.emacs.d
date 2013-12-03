;;flymake
;;実質flycheckの設定 便利
;;http://d.hatena.ne.jp/kitokitoki/20101230
(require 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(setq flycheck-highlighting-mode 'nil);下線があると,_が見えなくなる
(setq flycheck-check-syntax-automatically '(mode-enabled save));セーブした時だけにチェック
(setq flycheck-display-errors-function 'nil);;Echoエリアにエラーを表示しない

(setq flycheck-indication-mode 'left-fringe)
