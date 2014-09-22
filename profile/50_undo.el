;; -*- lexical-binding: t -*-

(require 'undo-tree)

(defun strict-global-undo-tree-mode ()
  (undo-tree-mode 1))
(add-hook 'find-file-hook 'strict-global-undo-tree-mode)

(custom-set-variables '(undo-tree-visualizer-timestamps t))

(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "s")   'undo-tree-visualize-switch-branch-right)
(define-key undo-tree-visualizer-mode-map (kbd "t")   'undo-tree-visualize-undo)

(require 'undohist);undoをファイル閉じても保存
(custom-set-variables
 '(undohist-directory "~/.undohist")
 '(undohist-ignored-files '("COMMIT_EDITMSG"))
 )
(undohist-initialize)

(require 'point-undo)
(global-set-key (kbd "M-/") 'point-undo)
(global-set-key (kbd "M-?") 'point-redo)
