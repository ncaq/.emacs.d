(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

(defface my-face-tab '((t (:background "#003636"))) nil)
(defvar my-face-tab 'my-face-tab)
(defface my-face-space '((t (:background "#003616"))) nil)
(defvar my-face-space 'my-face-space)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("\t"  0 my-face-tab   append)
     ("[ ]" 0 my-face-space append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(which-function-mode 1);ウィンドウの下部に現在の関数名を表示します。
(custom-set-faces '(which-func ((t (:foreground "#a3a1a1")))));;現在の函数表示,デフォルトだと色がかぶって見辛い

(show-paren-mode t);対応する括弧をハイライト

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
(custom-set-faces '(rainbow-delimiters-depth-1-face ((t (:foreground "#7f8c8d")))));文字列の色と被るため,変更
