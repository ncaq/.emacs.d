;;EmacsのデフォルトのKeyindには特に意味はない
;;ユーザが勝手に設定することを前提としている…と思う

;;h,t,n,sの移動設定
(global-set-key (kbd "C-h")   'backward-char)
(global-set-key (kbd "M-h")   'backward-word)
(global-set-key (kbd "C-M-h") 'backward-sexp)

(global-set-key (kbd "C-t")   'previous-line)
(global-set-key (kbd "M-t")   'backward-paragraph)
(global-set-key (kbd "C-M-t") 'scroll-down-one)

(global-set-key (kbd "M-n")   'forward-paragraph)
(global-set-key (kbd "C-M-n") 'scroll-up-one)

(global-set-key (kbd "C-s")   'forward-char)
(global-set-key (kbd "M-s")   'forward-word)
(global-set-key (kbd "C-M-s") 'forward-sexp)

;;余ったpを適当に
(global-set-key (kbd "C-p")   'other-window)
(global-set-key (kbd "M-p")   'split-window-right)

;;bは削除系
(global-set-key (kbd "C-b")   'backward-delete-char-untabify)
(global-set-key (kbd "M-b")   'backward-kill-word)

;;sのsearchをfのfindで置き換え
(global-set-key (kbd "C-f")   'isearch-forward)
(global-set-key (kbd "M-f")   'helm-occur)
(global-set-key (kbd "C-M-f") 'isearch-forward-regexp)

;;
(define-key minibuffer-local-map (kbd "M-s") nil)
(require 'comint)
(define-key comint-mode-map (kbd "M-t") 'comint-previous-input)