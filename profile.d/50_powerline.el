(require 'powerline)
(defun powerline-ncaq-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
		'("%e"
		  (:eval
		   (let* ((active (powerline-selected-window-active))
			  (mode-line (if active 'mode-line 'mode-line-inactive))
			  (face1 (if active 'powerline-active1 'powerline-inactive1))
			  (face2 (if active 'powerline-active2 'powerline-inactive2))
			  (separator-left
			   (intern (format "powerline-%s-%s"
					   powerline-default-separator
					   (car powerline-default-separator-dir))))
			  (separator-right
			   (intern (format "powerline-%s-%s"
					   powerline-default-separator
					   (cdr powerline-default-separator-dir))))
			  (lhs (list
				(powerline-raw "%*" nil)
				(powerline-buffer-size nil 'l)
				(powerline-raw mode-line-mule-info nil 'l)
				(powerline-raw (replace-regexp-in-string (concat "^" (getenv "HOME")) "~" (powerline-buffer-id)) nil 'l)
				(funcall separator-left mode-line face2)
				(when (boundp 'erc-modified-channels-object)
				  (powerline-raw erc-modified-channels-object face1 'l))))
			  (rhs (list
				(funcall separator-right face2 face1)
				(powerline-major-mode face1)
				(powerline-process face1 'r)
				(powerline-minor-modes face1 'l)
				(powerline-narrow face1 'l)
				(powerline-raw global-mode-string face2)
				(funcall separator-right face1 nil)
				(powerline-raw "%l");現在の行
				(powerline-raw "/")
				(powerline-raw (format "%d" (count-lines (point-max)(point-min))));行の総計
				(powerline-raw ":")
				(powerline-raw "%c");;現在のColumn
				(powerline-raw "/")
				(powerline-raw
				 (format "%d"
					 (length
					  (replace-regexp-in-string
					   "\t"
					   (make-string tab-width ? )
					   (buffer-substring-no-properties (point-at-bol)(point-at-eol)))))
				 );;Columnの総計
				(powerline-raw ":")
				(powerline-raw (format "%d" (point)));;現在のchar数
				(powerline-raw "/")
				(powerline-raw (format "%d" (- (point-max) (point-min)))))));;文字総計
		     (concat
		      (powerline-render lhs)
		      (powerline-fill face2 (powerline-width rhs))
		      (powerline-render rhs)))))))

(powerline-ncaq-theme)
