(require 'd-mode)
(require 'flymake)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))

(defun ncaq-d-mode-setup ()
  ;;(clang-delete)
  ;;(ac-d-mode-setup)
  (flycheck-mode)
  (local-set-key (kbd "C-c s") 'code-format-c)
  (local-set-key (kbd "M-z") 'code-format-c))
(add-hook 'd-mode-hook 'ncaq-d-mode-setup)

(require 'ac-dcd)
(add-to-list 'ac-modes 'd-mode)
(defun ac-d-mode-setup ()
  (setq ac-sources (append '(ac-source-dcd) ac-sources)))
(add-hook 'd-mode-hook 'ac-d-mode-setup)

;; (require 'etags)
;; ;;(autoload 'helm-yaetags "ncaq-d-etags")
;; (require 'helm-yaetags)

;; (defun etags-update-d ()
;;   (async-shell-command "dtags"))

;; (defun ncaq-d-etags ()
;;   (local-set-key (kbd "C-.") 'helm-etags-select)
;;   (local-set-key (kbd "M-.") 'pop-tag-mark)
;;   (etags-update-d)
;;   (add-hook 'after-save-hook 'etags-update-d nil 'make-it-local))

;; (add-hook 'd-mode-hook 'ncaq-d-etags)
