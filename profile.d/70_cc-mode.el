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


;;flymake
;;makeファイルを使わない
(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(add-hook 'c++-mode-hook 'flymake-mode-on)
