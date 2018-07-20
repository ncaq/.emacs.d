;; -*- lexical-binding: t -*-

(require 'undo-tree)

(global-undo-tree-mode)

(custom-set-variables
 '(undo-tree-auto-save-history t)
 '(undo-tree-enable-undo-in-region nil)
 '(undo-tree-history-directory-alist `(("" . ,(concat user-emacs-directory "undo-tree/"))))
 '(undo-tree-visualizer-timestamps t)
 )

(ncaq-set-key undo-tree-visualizer-mode-map)
(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)

(require 'point-undo)

(global-set-key (kbd "M-/") 'point-undo)
(global-set-key (kbd "M-?") 'point-redo)
