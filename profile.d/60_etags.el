;; (require 'etags)
;; (autoload 'helm-yaetags "ncaq-etags")
;; ;;emacsで保存した時にetags更新
;; (defun etags-update ()
;;   (if (file-exists-p "./TAGS")
;;       (call-process "etags" nil nil nil "-e *")))
;; (defun ncaq-etags ()
;;   (local-set-key (kbd "C-.") 'helm-etags-select)
;;   (local-set-key (kbd "M-.") 'pop-tag-mark)
;;   (add-hook 'after-save-hook 'etags-update nil 'make-it-local))

;; (add-hook 'lisp-mode-hook 'ncaq-etags)
;; (add-hook 'emacs-lisp-mode-hook 'ncaq-etags)
