(defun ncaq-c++-mode-set ()
  ;;C++ style
  ;;http://www.02.246.ne.jp/~torutk/cxx/emacs/indentation.html
  (c-set-style "bsd")
  ;;連続する空白削除
  (c-toggle-hungry-state 1)
  ;; CamelCaseの語でも単語単位に分解して編集する
  ;; GtkWindow         => Gtk Window
  ;; EmacsFrameClass   => Emacs Frame Class
  ;; NSGraphicsContext => NS Graphics Context
  (subword-mode 1)
  ;;gnu globalを自動的に有効にする
  ;;http://d.hatena.ne.jp/Nos/20120723/1343204409
  (gtags-mode)
  (setq gtags-suggested-key-mapping t)
  )

(add-hook 'c-mode-common-hook 'ncaq-c++-mode-set)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く
