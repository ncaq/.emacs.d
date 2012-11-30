;; C++
					; ヘッダファイル(.h)をc++モードで開く
(setq auto-mode-alist
      (append '(("\\.h$" . c++-mode))
              auto-mode-alist))
;; C++
					; ヘッダファイル(.hpp)をc++モードで開く
(setq auto-mode-alist
      (append '(("\\.hpp$" . c++-mode))
              auto-mode-alist))

;;C++ style
;;http://www.02.246.ne.jp/~torutk/cxx/emacs/indentation.html
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "bsd")
	     ))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     ;;連続する空白削除
	     (c-toggle-hungry-state 1)
	     ))

(add-hook 'c++-mode-hook
	  ;; CamelCaseの語でも単語単位に分解して編集する
	  ;; GtkWindow         => Gtk Window
	  ;; EmacsFrameClass   => Emacs Frame Class
	  ;; NSGraphicsContext => NS Graphics Context
	  (subword-mode 1))

;;gnu globalを自動的に有効にする
;;http://d.hatena.ne.jp/Nos/20120723/1343204409
(add-hook 'c++-mode-hook
 	  '(lambda()
 	     (gtags-mode 1)
 	     (setq gtags-suggested-key-mapping t)
 	     ))
