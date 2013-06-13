(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語
(add-hook 'd-mode-hook 'flymake-d-load)
