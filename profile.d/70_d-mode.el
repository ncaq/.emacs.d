(autoload 'd-mode "d-mode" "Major mode for editing D code." t);D言語
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))

(require 'auto-complete-d)
;;d-modeはcc-modeを改造したものなため,d-modeを起動するとD言語書いてるのにC++の補完システムが起動してしまう.
;;やっつけでこれを防ぐ
(defun clang-delete()
  (pop ac-sources))

(defun ncaq-d-mode-setup ()
  (flymake-d-load)
  (clang-delete)
  (ac-d-mode-setup)
  (local-set-key (kbd "C-i") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)
