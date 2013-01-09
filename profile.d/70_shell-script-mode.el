(add-to-list 'load-path "~/.emacs.d/bigprogram.d/emacs-bash-completion/")
(autoload 'bash-completion-dynamic-complete "bash-completion" "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)
(add-hook 'shell-command-complete-functions 'bash-completion-dynamic-complete)
