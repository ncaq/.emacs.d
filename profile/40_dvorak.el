;; -*- lexical-binding: t -*-

;; (kbd x)上のxをdvorak用に置き換え

(define-key key-translation-map (kbd "b") (kbd "h"))
(define-key key-translation-map (kbd "B") (kbd "H"))
(define-key key-translation-map (kbd "C-b") (kbd "C-h"))
(define-key key-translation-map (kbd "M-b") (kbd "M-h"))
(define-key key-translation-map (kbd "C-M-b") (kbd "C-M-h"))
(define-key key-translation-map (kbd "C-S-b") (kbd "C-S-h"))

(define-key key-translation-map (kbd "h") (kbd "b"))
(define-key key-translation-map (kbd "H") (kbd "B"))
(define-key key-translation-map (kbd "C-h") (kbd "C-b"))
(define-key key-translation-map (kbd "M-h") (kbd "M-b"))
(define-key key-translation-map (kbd "C-M-h") (kbd "C-M-b"))
(define-key key-translation-map (kbd "C-S-h") (kbd "C-S-b"))

(define-key key-translation-map (kbd "f") (kbd "s"))
(define-key key-translation-map (kbd "F") (kbd "S"))
(define-key key-translation-map (kbd "C-f") (kbd "C-s"))
(define-key key-translation-map (kbd "M-f") (kbd "M-s"))
(define-key key-translation-map (kbd "C-M-f") (kbd "C-M-s"))
(define-key key-translation-map (kbd "C-S-f") (kbd "C-S-s"))

(define-key key-translation-map (kbd "s") (kbd "f"))
(define-key key-translation-map (kbd "S") (kbd "F"))
(define-key key-translation-map (kbd "C-s") (kbd "C-f"))
(define-key key-translation-map (kbd "M-s") (kbd "M-f"))
(define-key key-translation-map (kbd "C-M-s") (kbd "C-M-f"))
(define-key key-translation-map (kbd "C-S-s") (kbd "C-S-f"))

(define-key key-translation-map (kbd "p") (kbd "t"))
(define-key key-translation-map (kbd "P") (kbd "T"))
(define-key key-translation-map (kbd "C-p") (kbd "C-t"))
(define-key key-translation-map (kbd "M-p") (kbd "M-t"))
(define-key key-translation-map (kbd "C-M-p") (kbd "C-M-t"))
(define-key key-translation-map (kbd "C-S-p") (kbd "C-S-t"))

(define-key key-translation-map (kbd "t") (kbd "p"))
(define-key key-translation-map (kbd "T") (kbd "P"))
(define-key key-translation-map (kbd "C-t") (kbd "C-p"))
(define-key key-translation-map (kbd "M-t") (kbd "M-p"))
(define-key key-translation-map (kbd "C-M-t") (kbd "C-M-p"))
(define-key key-translation-map (kbd "C-S-t") (kbd "C-S-p"))

;; 実際には入れ替わっている

;; h
(global-set-key (kbd "b")     '(lambda ()(interactive)(insert ?h)))
(global-set-key (kbd "B")     '(lambda ()(interactive)(insert ?H)))
(global-set-key (kbd "C-b")   'backward-char)
(global-set-key (kbd "C-b")   'backward-char)
(global-set-key (kbd "M-b")   'backward-word)
(global-set-key (kbd "C-M-b") 'backward-sexp)

;; b
(global-set-key (kbd "h")     '(lambda ()(interactive)(insert ?b)))
(global-set-key (kbd "H")     '(lambda ()(interactive)(insert ?B)))
(global-set-key (kbd "C-h")   'backward-delete-char-untabify)
(global-set-key (kbd "M-h")   'backward-kill-word)
(global-set-key (kbd "C-M-h") 'backward-kill-sexp)
(global-set-key (kbd "C-S-h") 'smart-delete-whitespace-backward)

;; s
(global-set-key (kbd "f")     '(lambda ()(interactive)(insert ?s)))
(global-set-key (kbd "F")     '(lambda ()(interactive)(insert ?S)))
(global-set-key (kbd "C-f")   'forward-char)
(global-set-key (kbd "M-f")   'forward-word)
(global-set-key (kbd "C-M-f") 'forward-sexp)

;; f
(global-set-key (kbd "s")     '(lambda ()(interactive)(insert ?f)))
(global-set-key (kbd "S")     '(lambda ()(interactive)(insert ?F)))
(global-set-key (kbd "C-s")   'isearch-forward)
(global-set-key (kbd "M-s")   'helm-occur)
(global-set-key (kbd "C-M-s") 'isearch-forward-regexp)

;; t
(global-set-key (kbd "p")     '(lambda ()(interactive)(insert ?t)))
(global-set-key (kbd "P")     '(lambda ()(interactive)(insert ?T)))
(global-set-key (kbd "C-p")   'previous-line)
(global-set-key (kbd "M-p")   'scroll-down-one)
(global-set-key (kbd "C-M-p") 'backward-paragraph)

;; p
(global-set-key (kbd "t")     '(lambda ()(interactive)(insert ?p)))
(global-set-key (kbd "T")     '(lambda ()(interactive)(insert ?P)))
(global-set-key (kbd "C-t")   'other-window)
(global-set-key (kbd "M-t")   'other-window-backward)
(global-set-key (kbd "C-M-t") 'split-window-right)

;; n(not changing)
(global-set-key (kbd "C-n")   'next-line)
(global-set-key (kbd "M-n")   'scroll-up-one)
(global-set-key (kbd "C-M-n") 'forward-paragraph)

(define-key isearch-mode-map (kbd "b") '(lambda ()(interactive)(isearch-printing-char ?h)))
(define-key isearch-mode-map (kbd "h") '(lambda ()(interactive)(isearch-printing-char ?b)))
(define-key isearch-mode-map (kbd "B") '(lambda ()(interactive)(isearch-printing-char ?H)))
(define-key isearch-mode-map (kbd "H") '(lambda ()(interactive)(isearch-printing-char ?B)))

(define-key isearch-mode-map (kbd "f") '(lambda ()(interactive)(isearch-printing-char ?s)))
(define-key isearch-mode-map (kbd "s") '(lambda ()(interactive)(isearch-printing-char ?f)))
(define-key isearch-mode-map (kbd "F") '(lambda ()(interactive)(isearch-printing-char ?S)))
(define-key isearch-mode-map (kbd "S") '(lambda ()(interactive)(isearch-printing-char ?F)))

(define-key isearch-mode-map (kbd "p") '(lambda ()(interactive)(isearch-printing-char ?t)))
(define-key isearch-mode-map (kbd "t") '(lambda ()(interactive)(isearch-printing-char ?p)))
(define-key isearch-mode-map (kbd "P") '(lambda ()(interactive)(isearch-printing-char ?T)))
(define-key isearch-mode-map (kbd "T") '(lambda ()(interactive)(isearch-printing-char ?P)))

(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
(define-key isearch-mode-map (kbd "M-h") 'isearch-del-char)

(define-key isearch-mode-map (kbd "M-m") 'isearch-exit-previous)

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd "b") 'Info-history-back)
  (define-key Info-mode-map (kbd "f") 'Info-history-forward)

  (define-key Info-mode-map (kbd "p") 'Info-prev)
  (define-key Info-mode-map (kbd "h") 'Info-up)
  )

(with-eval-after-load 'help-mode
  (define-key help-mode-map (kbd "b") 'help-go-back)
  (define-key help-mode-map (kbd "f") 'help-go-forward)

  (define-key help-mode-map (kbd "p") 'help-go-back)
  (define-key help-mode-map (kbd "n") 'help-go-forward)
  )

(with-eval-after-load 'man
  (define-key Man-mode-map (kbd "M-p")   'nil)
  (define-key Man-mode-map (kbd "C-c p") 'Man-previous-manpage)
  (define-key Man-mode-map (kbd "M-n")   'nil)
  (define-key Man-mode-map (kbd "C-c n") 'Man-next-manpage)
  )

(with-eval-after-load 'nxml-mode
  (define-key nxml-mode-map (kbd "M-h") 'nil)
  )

(with-eval-after-load 'make-mode
  (define-key makefile-mode-map (kbd "M-p") 'nil)
  (define-key makefile-mode-map (kbd "M-n") 'nil)
  )

(with-eval-after-load 'hexl
  (define-key hexl-mode-map (kbd "C-q") 'nil)

  (define-key hexl-mode-map [remap quoted-insert] 'hexl-quoted-insert)
  )
