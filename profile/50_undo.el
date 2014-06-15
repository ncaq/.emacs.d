;; -*- lexical-binding: t -*-
(require 'undo-tree);undoをtreeに,C-x C-uで起動
(add-hook 'find-file-hook (lambda () (undo-tree-mode 1)))
(custom-set-variables '(undo-tree-visualizer-timestamps t))

(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "s") 'undo-tree-visualize-switch-branch-right)
(define-key undo-tree-visualizer-mode-map (kbd "t") 'undo-tree-visualize-undo)

(require 'undohist);;undoをファイル閉じても保存
(custom-set-variables '(undohist-directory "~/.emacs.d/undohist"))
(undohist-initialize)

;; Original copylight and license
;;; undohist.el --- Persistent undo history for GNU Emacs
;; Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014  Tomohiro Matsuyama
;; Author: MATSUYAMA Tomohiro <tomo@cx4a.org>
;; Package-Requires: ((cl-lib "1.0"))
;; Keywords: convenience
;; Version: 20140321.758
;; X-Original-Version: 0.2

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
(defun undohist-recover-1 ()
  (let* ((buffer (current-buffer))
         (file (buffer-file-name buffer))
         (undo-file (make-undohist-file-name file))
         undo-list)
    (when (and (undohist-recover-file-p file)
               (file-exists-p undo-file))
      (with-temp-buffer
        (insert-file-contents undo-file)
        (goto-char (point-min))
        (let ((alist (undohist-decode (read (current-buffer)))))
          (if (string= (md5 buffer) (assoc-default 'digest alist))
              (setq undo-list (assoc-default 'undo-list alist))
            (message "File digest doesn't match, so undo history will be discarded."))))
      (when (consp undo-list)
        (setq buffer-undo-list undo-list)))))
