;; -*- lexical-binding: t -*-
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t) ;http://www.okada.jp.org/RWiki/?ESS

(custom-set-variables
 '(auto-mode-alist
   (append
    '(
      ("\\.R\\'"          . R-mode)
      ("\\.license\\'"    . conf-mode)
      ("\\.mask\\'"       . conf-mode)
      ("\\.r\\'"          . R-mode)
      ("\\.ssh/config\\'" . ssh-config-mode)
      ("\\.unmask\\'"     . conf-mode)
      ("\\.use\\'"        . conf-mode)
      ("\\.zsh\\'"        . shell-script-mode)
      ("nginx.conf\\'"    . nginx-mode)
      ("sshd?_config\\'"  . ssh-config-mode)
      )
    auto-mode-alist))
 '(scheme-program-name "gosh"))
(defvar inferior-lisp-program "clisp")
