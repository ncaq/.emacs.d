(require 'ibus)
(ibus-mode-on)

(setenv "XMODIFIERS" "@im=none")

(setq ibus-cursor-color '("#859900" "#839496" "#002b36"))
(setq ibus-prediction-window-position t)
(setq ibus-undo-by-committed-string t)

(define-key ibus-mode-map (kbd "C-;") 'ibus-toggle)
(define-key ibus-mode-map (kbd "C-SPC") nil)
(define-key ibus-mode-preedit-map (kbd "C-g") 'ibus-keyboard-quit)
(define-key ibus-mode-preedit-map (kbd "RET") 'ibus-commit)

(add-hook 'ibus-preedit-show-hook 'disable-trans-h-b)
(add-hook 'ibus-commit-string-hook 'enable-trans-h-b)

(defun ibus-keyboard-quit ()
  (interactive)
  (enable-trans-h-b)
  (ibus-handle-event))

(defun ibus-commit ()
  (interactive)
  (enable-trans-h-b)
  (ibus-handle-event))

(defun disable-trans-h-b ()
  ;;h,bの入れ替え
  (define-key key-translation-map (kbd "C-h") nil)
  (define-key key-translation-map (kbd "M-h") nil)
  (define-key key-translation-map (kbd "C-M-h") nil)
  (define-key key-translation-map (kbd "C-S-h") nil)

  (define-key key-translation-map (kbd "C-b") nil)
  (define-key key-translation-map (kbd "M-b") nil)
  (define-key key-translation-map (kbd "C-M-b") nil)
  (define-key key-translation-map (kbd "C-S-b") nil))

(defun enable-trans-h-b ()
  ;;h,bの入れ替え
  (define-key key-translation-map (kbd "C-h") (kbd "C-b"))
  (define-key key-translation-map (kbd "M-h") (kbd "M-b"))
  (define-key key-translation-map (kbd "C-M-h") (kbd "C-M-b"))
  (define-key key-translation-map (kbd "C-S-h") (kbd "C-S-b"))

  (define-key key-translation-map (kbd "C-b") (kbd "C-h"))
  (define-key key-translation-map (kbd "M-b") (kbd "M-h"))
  (define-key key-translation-map (kbd "C-M-b") (kbd "C-M-h"))
  (define-key key-translation-map (kbd "C-S-b") (kbd "C-S-h")))
