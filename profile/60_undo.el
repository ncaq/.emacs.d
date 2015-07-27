;; -*- lexical-binding: t -*-

(require 'undo-tree)

(global-undo-tree-mode)

(custom-set-variables
 '(undo-tree-auto-save-history t)
 '(undo-tree-history-directory-alist '(("". "~/.undo-tree")))
 '(undo-tree-visualizer-timestamps t)
 )

(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "s")   'undo-tree-visualize-switch-branch-right)
(define-key undo-tree-visualizer-mode-map (kbd "t")   'undo-tree-visualize-undo)

(require 'point-undo)

(global-set-key (kbd "M-/") 'point-undo)
(global-set-key (kbd "M-?") 'point-redo)
