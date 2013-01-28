;;http://d.hatena.ne.jp/yuto_sasaki/20120310/1331362118
;;カーソル下の数字っぽいものをインクリメント・デクリメントする
(defun operate-string-as-number (number op)
  (let ((col (current-column))
        (p (if (integerp number) number 1))
        )
    (skip-chars-backward "-0123456789")
    (or (looking-at "-?[0123456789]+")
        (error "No number at point"))
    (replace-match
     (number-to-string (funcall op (string-to-number (match-string 0)) p)))
    (move-to-column col)))
(defun increment-string-as-number (number)
  "Replace progression string of the position of the cursor
by string that added NUMBER.
Interactively, NUMBER is the prefix arg.

example:
At the cursor string \"12\"

M-x increment-string-as-number ;; replaced by \"13\"
C-u 10 M-x increment-string-as-number ;; replaced by \"22\"

At the cursor string \"-12\"

M-x increment-string-as-number ;; replaced by \"-11\"
C-u 100 M-x increment-string-as-number ;; replaced by \"88\""
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (+ x y)))
  )

(defun decrement-string-as-number (number)
  "Replace progression string of the position of the cursor
by string that subtracted NUMBER.
Interactively, NUMBER is the prefix arg.

example:
At the cursor string \"12\"

M-x increment-string-as-number ;; replaced by \"11\"
C-u 10 M-x increment-string-as-number ;; replaced by \"2\"

At the cursor string \"-12\"

M-x increment-string-as-number ;; replaced by \"-13\"
C-u 100 M-x increment-string-as-number ;; replaced by \"-112\""
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (- x y)))
  )

;; smart-rep
(global-set-key (kbd "C-+") 'increment-string-as-number)
(global-set-key (kbd "C--") 'decrement-string-as-number)
