(global-font-lock-mode 1);syntax highlight有効

(require 'solarized-dark-theme)
(load-theme 'solarized-dark t)

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

(show-paren-mode t);対応する括弧をハイライト

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
(custom-set-faces '(rainbow-delimiters-depth-1-face ((t (:foreground "#7f8c8d")))));文字列の色と被るため,変更
