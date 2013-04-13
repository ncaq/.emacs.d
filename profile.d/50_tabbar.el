(require 'tabbar)
(eval-when-compile (require 'cl))
(tabbar-mode 1)

;;http://d.hatena.ne.jp/tequilasunset/20110103/p1
;;Operaライクなキーバインドに
(global-set-key [(control tab)] 'tabbar-forward)
(global-set-key [(control shift iso-lefttab)] 'tabbar-backward)
;; -nw では効かないので別のキーバインドを割り当てる
(global-set-key (kbd "C-x n") 'tabbar-forward)
(global-set-key (kbd "C-x p") 'tabbar-backward)

;;タブをグループ化しない
(setq tabbar-buffer-groups-function nil)

;;http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
;;リスト8 " *"で始まるバッファをタブとして表示しない
(defun my-tabbar-buffer-list ()
  (remove-if
   (lambda (buffer)
     (find (aref (buffer-name buffer) 0) " *"))
   (buffer-list)))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;;外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Ricty"
 :background "#93a1a1"
 :foreground "#002b36"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "#002b36"
 :foreground "#93a1a1"
 :box t)
(set-face-attribute
 'tabbar-selected nil
 :background "#93a1a1"
 :foreground "#002b36"
 :box t)
(set-face-attribute
 'tabbar-button nil
 :box t)
(set-face-attribute
 'tabbar-separator nil
 :height 10)
