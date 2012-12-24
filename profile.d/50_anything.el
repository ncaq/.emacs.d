(require 'anything-startup)

;;http://d.hatena.ne.jp/kitokitoki/20111217/
(defun anything-default-display-buffer (buf)
  (if anything-samewindow
      (switch-to-buffer buf)
    (progn
      (delete-other-windows)
      (split-window (selected-window) nil t)
      (pop-to-buffer buf))))

;;バッファリストをanythingのものに
(global-set-key "\C-xb" 'anything-buffers-list)

(require 'anything-include)
(add-to-list 'anything-sources 'anything-c-source-include)
