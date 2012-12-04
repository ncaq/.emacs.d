(add-to-list 'load-path "~/.emacs.d/bigprogram.d/popup-el/");popup.elが必要

;;http://cx4a.org/software/auto-complete/manual.ja.html
(add-to-list 'load-path "~/.emacs.d/bigprogram.d/auto-complete/");ここにインストールしてるのでー

(require 'auto-complete)
(require 'auto-complete-config)

;;自動で補完画面を出すならt。補完キーを押すまで補完画面を出さないならnil
(setq ac-auto-start nil)

;;補完画面からさらにそのヘルプ画面が出るまでの遅延（秒）
(setq ac-quick-help-delay 0)

;; 大文字・小文字を区別しない
(setq ac-ignore-case t)

;;補完キー指定。お好みで。
(ac-set-trigger-key "TAB")

;;http://www.nomtats.com/2010/11/auto-completeelemacs.html
(defun my-ac-config ()
  (global-set-key [?\C-,] 'ac-start)
  ;; C-n/C-p で候補を選択
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (setq-default ac-sources '(ac-source-abbrev 
			     ac-source-dictionary 
			     ac-source-words-in-same-mode-buffers))
  (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)
