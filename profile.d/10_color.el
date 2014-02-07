(global-font-lock-mode 1);syntax highlight有効

(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

;;空白とタブに色を付ける
(defface ncaq-tab-face '((t :background "#003636")) nil)
(defvar  ncaq-tab-face 'ncaq-tab-face)
(defface ncaq-space-face '((t :background "#003616")) nil)
(defvar  ncaq-space-face 'ncaq-space-face)
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
(defface face-for-executable '((t :foreground "#5f8700")) nil)
(defvar  face-for-executable 'face-for-executable)

(eval-after-load "dired"
  '(add-to-list
    'dired-font-lock-keywords
    (list dired-re-exe
	  '(".+" (dired-move-to-filename) nil (0 'face-for-executable)))))

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
(custom-set-faces '(rainbow-delimiters-depth-1-face ((t (:foreground "#7f8c8d")))));文字列の色と被るため,変更
