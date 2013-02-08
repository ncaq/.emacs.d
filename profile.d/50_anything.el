					;(require 'anything-ipython)
(require 'anything-complete)
(require 'anything-el-swank-fuzzy)
(require 'anything-extension)
(require 'anything-exuberant-ctags)
(require 'anything-git-goto)
(require 'anything-include)
(require 'anything-match-plugin)
					;(require 'anything-migemo)
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

;;バッファリストをanythingのものに
(global-set-key "\C-xb" 'anything)
