(require 'helm-config)
(helm-mode 1)

(require 'helm-descbinds)
(helm-descbinds-mode)

(require 'helm-ag)

;;helmのBufferを縦に表示する ワイドディスプレイの時代だし
(defun helm-default-display-buffer (buf)
  (if helm-full-frame
      (switch-to-buffer buf)
    (progn
      (delete-other-windows)
      (split-window (selected-window) nil t)
      (pop-to-buffer buf))))
