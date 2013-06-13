(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語

(defun ncaq-d-mode-set ()
  (flymake-d-load)
  (subword-mode t)
  (local-set-key (kbd "C-i") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-set)
