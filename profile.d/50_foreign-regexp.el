(add-to-list 'load-path "~/.emacs.d/bigprogram.d/foreign-regexp.el/")

(require 'foreign-regexp)

(custom-set-variables
 '(foreign-regexp/regexp-type 'perl) ;; Choose by your preference.
 '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.
