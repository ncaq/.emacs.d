(add-to-list 'custom-theme-load-path "~/.emacs.d/bigprogram.d/emacs-color-theme-solarized/")
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
