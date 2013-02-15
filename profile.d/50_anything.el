					;(require 'anything-ipython)
					;(require 'anything-migemo)
(require 'anything)
(require 'anything-complete)
(require 'anything-config)
(require 'anything-el-swank-fuzzy)
(require 'anything-extension)
(require 'anything-exuberant-ctags)
(require 'anything-git-goto)
(require 'anything-grep)
(require 'anything-gtags)
(require 'anything-include)
(require 'anything-match-plugin)
(require 'anything-obsolete)
(require 'anything-show-completion)
(require 'anything-startup)
(require 'descbinds-anything)

;;http://d.hatena.ne.jp/kitokitoki/20111217/
(defun anything-default-display-buffer (buf)
  (if anything-samewindow
      (switch-to-buffer buf)
    (progn
      (delete-other-windows)
      (split-window (selected-window) nil t)
      (pop-to-buffer buf))))

;;http://d.hatena.ne.jp/tomoya/20090424/1240571958
(setq anything-idle-delay 0);;候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq anything-input-idle-delay 0);;文字列を入力してから検索するまでのタイムラグ。デフォルトで 0
(setq anything-candidate-number-limit 300);;表示する最大候補数。デフォルトで 50
