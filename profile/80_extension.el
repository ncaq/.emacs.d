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

(with-eval-after-load 'nxml-mode
  (define-key nxml-mode-map (kbd "C-M-n") 'nil)
  (define-key nxml-mode-map (kbd "M-h")   'nil)
  )

(with-eval-after-load 'make-mode
  (define-key makefile-mode-map (kbd "M-n") 'nil)
  (define-key makefile-mode-map (kbd "M-t") 'nil)
  )

(with-eval-after-load 'hexl
  (define-key hexl-mode-map (kbd "C-M-t") 'nil)
  (define-key hexl-mode-map (kbd "C-f")   'nil)
  (define-key hexl-mode-map (kbd "C-h")   'hexl-backward-char)
  (define-key hexl-mode-map (kbd "C-q")   'nil)
  (define-key hexl-mode-map (kbd "C-s")   'hexl-forward-char)
  (define-key hexl-mode-map (kbd "C-t")   'hexl-previous-line)
  (define-key hexl-mode-map (kbd "M-f")   'nil)
  (define-key hexl-mode-map (kbd "M-h")   'hexl-backward-word)
  (define-key hexl-mode-map (kbd "M-s")   'hexl-forward-word)
  )
