(require 'flymake)

;;http://d.hatena.ne.jp/sugyan/20100705/1278306885
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;;http://d.hatena.ne.jp/nyaasan/20071216/p1
(defun flymake-cc-init ()
  (let* ((temp-file(flymake-init-create-temp-buffer-copy
		    'flymake-create-temp-inplace))
	 (local-file(file-relative-name
		     temp-file
		     (file-name-directory buffer-file-name))))
    (list "g++" (list "-std=c++0x" "-Wall" "-Werror" "-Wextra" "-fsyntax-only" local-file))))
(add-hook 'c++-mode-hook
	  '(lambda ()
	     (flymake-cc-init)
	     (flymake-mode t)))

;;Haskellバージョン
;;http://d.hatena.ne.jp/nushio/20071201
(global-set-key "\C-cd"
                'flymake-show-and-sit )

(setq haskell-doc-idle-delay 0.1)

(defun flymake-show-and-sit ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (progn
    (let* ( (line-no                     (flymake-current-line-no) )
            (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
            (count                               (length line-err-info-list))
            )
      (while (> count 0)
        (when line-err-info-list
          (let* ((file           (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (full-file      (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line           (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)
            )
          )
        (setq count (1- count)))))
  (sit-for 60.0)
  )

;; Auto enter flymake

(add-hook 'haskell-mode-hook
          '(lambda ()
             (flymake-mode)))

