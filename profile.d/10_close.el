(require 'undohist);;undoをファイル閉じても保存
(setq undohist-directory "~/.emacs.d/undohist")
(undohist-initialize)

(defun undohist-recover ()
  "Recover undo history."
  (interactive)
  (let ((buffer (current-buffer))
        (file (make-undohist-file-name (buffer-file-name)))
        undo-list)
    (if (not (file-exists-p file))
        '(message "Undo history file doesn't exists.")
      (when (null buffer-undo-list)
        (with-temp-buffer
          (insert-file-contents file)
          (goto-char (point-min))
          (let ((alist (undohist-decode (read (current-buffer)))))
            (if (string= (md5 buffer) (assoc-default 'digest alist))
                (setq undo-list (assoc-default 'undo-list alist))
              (message "File digest doesn't match, so undo history will be discarded."))))
        (if (consp undo-list)
            (setq buffer-undo-list undo-list))))))
