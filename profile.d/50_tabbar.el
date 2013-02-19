(require 'tabbar)
(require 'tabbar-ruler)
(eval-when-compile (require 'cl))
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

;;Sort tabbar buffers by name
(defun tabbar-add-tab (tabset object &optional append_ignored)
  "Add to TABSET a tab with value OBJECT if there isn't one there yet.
 If the tab is added, it is added at the beginning of the tab list,
 unless the optional argument APPEND is non-nil, in which case it is
 added at the end."
  (let ((tabs (tabbar-tabs tabset)))
    (if (tabbar-get-tab object tabset)
        tabs
      (let ((tab (tabbar-make-tab object tabset)))
        (tabbar-set-template tabset nil)
        (set tabset (sort (cons tab tabs)
                          (lambda (a b) (string< (buffer-name (car a)) (buffer-name (car b))))))))))

;;外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Ricty"
 :background "black"
 :foreground "white"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "black"
 :foreground "white"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "black"
 :foreground "red"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.5)
