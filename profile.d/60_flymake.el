;;flymake
;;makeファイルを使わない
(require 'flymake)
(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
		       temp-file
		       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" "-std=c++11" "-v" local-file))))
(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(add-hook 'c++-mode-hook 'flymake-mode-on)
