;;http://www.02.246.ne.jp/~torutk/cxx/emacs/mode_extension.html
(require 'cl)
(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () 
			      (setq file-without-ext (file-name-sans-extension
						      (file-name-nondirectory (buffer-file-name))))))
    ("%include%" .
     (lambda () 
       (cond ((string= namespace "") (concat "\"" file-without-ext ".h\""))
	     (t (concat "<" (replace-regexp-in-string "::" "/" namespace) "/"
			file-without-ext ".h>")))))
    ("%include-guard%" . 
     (lambda ()
       (format "%s_H_"
	       (upcase (concat 
			(replace-regexp-in-string "::" "_" namespace)
			(unless (string= namespace "") "_")
			file-without-ext)))))
    ("%name%" . user-full-name)
    ("%mail%" . (lambda () (identity user-mail-address)))
    ("%cyear%" . (lambda () (substring (current-time-string) -4)))
    ("%namespace-open%" .
     (lambda ()
       (cond ((string= namespace "") "")
	     (t (progn 
		  (setq namespace-list (split-string namespace "::"))
		  (setq namespace-text "")
		  (while namespace-list
		    (setq namespace-text (concat namespace-text "namespace "
                                                 (car namespace-list) " {\n"))
		    (setq namespace-list (cdr namespace-list))
		    )
		  (eval namespace-text))))))
    ("%namespace-close%" .
     (lambda ()
       (cond ((string= namespace "") "")
	     (t (progn
		  (setq namespace-list (reverse (split-string namespace "::")))
		  (setq namespace-text "")
		  (while namespace-list
		    (setq namespace-text (concat namespace-text "} // " (car namespace-list) "\n"))
		    (setq namespace-list (cdr namespace-list))
		    )
		  (eval namespace-text))))))
    ))
