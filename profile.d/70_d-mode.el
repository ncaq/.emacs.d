(require 'd-mode)
(require 'flymake)
(require 'flycheck)
(require 'auto-complete-d)
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))
;;d-modeはcc-modeを改造したものなため,d-modeを起動するとD言語書いてるのにC++の補完システムが起動してしまう.
;;やっつけでこれを防いでいた
;; (defun clang-delete()
;;   (pop ac-sources))

(defun ncaq-d-mode-setup ()
  ;;(clang-delete)
  ;;(ac-d-mode-setup)
  (flycheck-mode)
  (local-set-key (kbd "C-c s") 'code-format-c)
  (local-set-key (kbd "M-z") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)
