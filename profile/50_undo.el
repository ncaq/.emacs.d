(require 'undo-tree);undoをtreeに,C-x C-uで起動
(add-hook 'find-file-hook (lambda () (undo-tree-mode 1)))
(custom-set-variables '(undo-tree-visualizer-timestamps t))

(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "s") 'undo-tree-visualize-switch-branch-right)
(define-key undo-tree-visualizer-mode-map (kbd "t") 'undo-tree-visualize-undo)

(require 'undohist);;undoをファイル閉じても保存
(custom-set-variables '(undohist-directory "~/.emacs.d/undohist")
                      '(setq undohist-ignored-files ".*COMMIT_EDITMSG.*"))
(undohist-initialize)
