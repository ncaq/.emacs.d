(require 'ibuffer)
(setq ibuffer-formats
      '((mark modified read-only " " (name 30 30)
	      " " (size 6 -1) " " (mode 16 16) " " filename)
	(mark " " (name 30 -1) " " filename)))
