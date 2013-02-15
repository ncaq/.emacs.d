(defun ncaq-c++-mode-set ()
  (c-set-style "bsd");http://www.02.246.ne.jp/~torutk/cxx/emacs/indentation.html
  (c-toggle-hungry-state 1);連続する空白を一気に削除
  (local-set-key (kbd "C-\\") 'code-format-c);括弧も揃えるコードフォーマット;;gnu globalを自動的に有効にする
  ;;http://d.hatena.ne.jp/Nos/20120723/1343204409
  (gtags-mode)
  (setq gtags-suggested-key-mapping))
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
