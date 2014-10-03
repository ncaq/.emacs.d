;; -*- lexical-binding: t -*-

(eval-after-load 'processing-mode
  '(progn
     (custom-set-variables
      '(processing-location "~/Desktop/processing/processing-java/")
      '(processing-application-dir "~/Desktop/processing/")
      '(processing-output-dir "/tmp/")
      )

     (defun processing-mode-init ()
       (make-local-variable 'ac-user-dictionary)
       (custom-set-variables '(ac-user-dictionary
                               (append
                                processing-functions
                                processing-builtins
                                processing-constants))))
     (add-hook 'processing-mode-hook 'processing-mode-init)
     ))
