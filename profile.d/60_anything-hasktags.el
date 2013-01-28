(add-to-list 'load-path "~/.emacs.d/bigprogram.d/anything-hasktags/")
(require 'anything-hasktags)

(add-hook 'haskell-mode-hook
	  (lambda()
	    (define-key haskell-mode-map (kbd "M-.") 'anything-hasktags-select)))
