(require 'processing-mode)
(custom-set-variables '(processing-location "~/Desktop/processing/processing-java")
                      '(processing-application-dir "~/Desktop/processing/")
                      '(processing-output-dir "/tmp"))

(require 'auto-complete)
(defun processing-mode-init ()
  (make-local-variable 'ac-user-dictionary)
  (setq ac-user-dictionary (append processing-functions
                                   processing-builtins
                                   processing-constants)))
(add-hook 'processing-mode-hook 'processing-mode-init)