(add-to-list 'custom-theme-load-path "~/.emacs.d/package.d/emacs-color-theme-solarized/")
(load-theme 'solarized-dark t)

(defface my-face-b-2 '((t (:background "#073642"))) nil)
(defvar my-face-b-2 'my-face-b-2)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(custom-set-faces '(which-func ((t (:foreground "#a3a1a1")))));;現在の函数表示の場所
