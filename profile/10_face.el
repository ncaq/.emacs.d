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
