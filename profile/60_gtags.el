;; -*- lexical-binding: t -*-

(custom-set-variables '(ggtags-global-ignore-case t))

(defun gtags-dir? ()
  (locate-dominating-file default-directory "GTAGS"))

(defun ggtags-mode-when-gtags-dir ()
  (when (gtags-dir?)
    (ggtags-mode 1)))

(add-hook 'find-file-hook 'ggtags-mode-when-gtags-dir)
