(defun set-qt-set ()
  (setq compile-command "qmake;make"))
(add-hook 'c++-mode-hook 'set-qt-set)
