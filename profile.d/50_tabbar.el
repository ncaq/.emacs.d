(require 'tabbar)
(require 'tabbar-ruler)
(tabbar-mode 1)

;;http://d.hatena.ne.jp/tequilasunset/20110103/p1
;;Operaライクなキーバインドに
(global-set-key [(control tab)] 'tabbar-forward)
(global-set-key [(control shift iso-lefttab)] 'tabbar-backward)
;; -nw では効かないので別のキーバインドを割り当てる
(global-set-key (kbd "C-x n") 'tabbar-forward)
(global-set-key (kbd "C-x p") 'tabbar-backward)

;;http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
;;リスト8 " *"で始まるバッファをタブとして表示しない
(defun my-tabbar-buffer-list ()
  (remove-if
   (lambda (buffer)
     (find (aref (buffer-name buffer) 0) " *"))
   (buffer-list)))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
