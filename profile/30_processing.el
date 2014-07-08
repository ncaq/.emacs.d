(require 'processing-mode)
(custom-set-variables '(processing-location "/home/ncaq/Desktop/processing/processing-java")
                      '(processing-application-dir "/home/ncaq/Desktop/processing/")
                      '(processing-output-dir "/tmp"))

(require 'auto-complete)
(defun processing-mode-init ()
  (make-local-variable 'ac-sources)
  (setq ac-sources '(ac-source-dictionary ac-source-yasnippet))
  (make-local-variable 'ac-user-dictionary)
  (setq ac-user-dictionary (append processing-functions
                                   processing-builtins
                                   processing-constants)))

(add-to-list 'ac-modes 'processing-mode)
(add-hook 'processing-mode-hook 'processing-mode-init)