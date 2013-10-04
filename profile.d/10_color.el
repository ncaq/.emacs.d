(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

(defface my-face-tab '((t (:background "#003636"))) nil)
(defvar my-face-tab 'my-face-tab)
(defface my-face-space '((t (:background "#003616"))) nil)
(defvar my-face-space 'my-face-space)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("\t"  0 my-face-tab   append)
     ("[ ]" 0 my-face-space append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
