;; -*- lexical-binding: t -*-
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

;;余ったpにはwindow操作を割り当てる
(global-set-key (kbd "C-p")   'other-window)
(global-set-key (kbd "M-p")   'other-window-backward)
(global-set-key (kbd "C-M-p") 'split-window-right)

(defun other-window-backward ()
  (interactive)
  (other-window -1))

;;backspace
(global-set-key (kbd "C-b")   'backward-delete-char-untabify)
(global-set-key (kbd "M-b")   'backward-kill-word)
(global-set-key (kbd "C-M-b") 'backward-kill-sexp)

;;search→find
(global-set-key (kbd "C-f")   'isearch-forward)
(global-set-key (kbd "M-f")   'helm-occur)
(global-set-key (kbd "C-M-f") 'isearch-forward-regexp)

;; modes
(define-key minibuffer-local-map (kbd "M-s") 'nil)
(define-key minibuffer-local-map (kbd "M-p") 'nil)
(define-key minibuffer-local-map (kbd "M-t") 'previous-history-element)

(define-key isearch-mode-map (kbd "C-b") 'isearch-delete-char)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-s") 'nil)
(define-key isearch-mode-map (kbd "M-b") 'isearc-del-char)
(define-key isearch-mode-map (kbd "M-m") 'isearch-exit-previous)

(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "M-p") 'nil)
  (define-key comint-mode-map (kbd "M-t") 'comint-previous-input)
  )

(with-eval-after-load 'diff-mode
  (define-key diff-mode-map (kbd "M-h") 'nil))

(with-eval-after-load 'doc-view
  (define-key doc-view-mode-map (kbd "C-p") 'nil)
  (define-key doc-view-mode-map (kbd "C-t") 'doc-view-previous-line-or-previous-page)
  (define-key doc-view-mode-map (kbd "t")   'doc-view-previous-page)
  )

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd "h") 'Info-history-back)
  (define-key Info-mode-map (kbd "s") 'Info-history-forward)
  
  (define-key Info-mode-map (kbd "t") 'Info-prev)
  (define-key Info-mode-map (kbd "b") 'Info-up)
  )

(with-eval-after-load 'rect
  (define-key rectangle-mark-mode-map (kbd "C-t") 'nil)
  )