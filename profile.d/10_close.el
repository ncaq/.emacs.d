(require 'undohist);;undoをファイル閉じても保存
(setq undohist-directory "~/.emacs.d/undohist")
(undohist-initialize)

(defun undohist-recover-1 ()
  (let* ((buffer (current-buffer))
         (file (buffer-file-name buffer))
         (undo-file (make-undohist-file-name file))
         undo-list)
    (with-temp-buffer
      (insert-file-contents undo-file)
      (goto-char (point-min))
      (let ((alist (undohist-decode (read (current-buffer)))))
	(if (string= (md5 buffer) (assoc-default 'digest alist))
	    (setq undo-list (assoc-default 'undo-list alist))
	  (message "File digest doesn't match, so undo history will be discarded."))))
    (when (consp undo-list)
      (setq buffer-undo-list undo-list))))
