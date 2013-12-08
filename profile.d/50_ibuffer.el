(require 'ibuffer)
(setq ibuffer-formats
      '((mark modified read-only " " (name 60 30)
	      " " (size 6 -1) " " (mode 16 16) " " filename)
	(mark " " (name 60 -1) " " filename)))
