;; -*- lexical-binding: t -*-
;;空白とタブに色を付ける
(defface ncaq-tab-face   '((t (:background "#003636"))) nil)
(defface ncaq-space-face '((t (:background "#003616"))) nil)
(defadvice font-lock-mode (before ncaq-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("\t"  . 'ncaq-tab-face)
     ("[ ]" . 'ncaq-space-face)
     )))
(ad-enable-advice 'font-lock-mode 'before 'ncaq-font-lock-mode)
(ad-activate 'font-lock-mode)

;;diredの実行ファイルに色を付ける
(defface face-for-executable '((t (:foreground "#5f8700"))) nil)
(eval-after-load "dired"
  '(add-to-list
    'dired-font-lock-keywords
    (list dired-re-exe
          '(".+" (dired-move-to-filename) nil (0 'face-for-executable)))))

;; http://www.clear-code.com/blog/2012/4/3.html
;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(require 'diff-mode)
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)
