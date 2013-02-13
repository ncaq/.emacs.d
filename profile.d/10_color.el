;;背景を暗く
(set-face-foreground 'default "white")
(set-face-background 'default "black")
(setq frame-background-mode 'dark)

;;↓の有効にすると,auto-complete-modeが荒ぶるんですよね
;;(require 'whitespace-mode)
;;なので古代使われていたらしき方法で.
;;何やってるのかは良くわからん
;;http://ubulog.blogspot.jp/2007/09/emacs_09.html
(defface my-face-b-1 '((t (:background "#202000"))) nil :group 'font-lock-highlighting-faces)
(defface my-face-b-2 '((t (:background "#200000"))) nil :group 'font-lock-highlighting-faces)
(defface my-face-u-1 '((t (:background "#001000"))) nil :group 'font-lock-highlighting-faces)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("[ ]" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("\n" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
			      (if font-lock-mode
				  nil
				(font-lock-mode t))))
