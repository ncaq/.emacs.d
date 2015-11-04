;; -*- lexical-binding: t -*-

(defun reverse-cons (c)
  (cons (cdr c) (car c)))

(defun trans-bind (key-map key-pair)
  (cons (kbd (car key-pair)) (command-or-nil (lookup-key key-map (kbd (cdr key-pair))))))

(defun command-or-nil (symbol)
  (when (commandp symbol) symbol))

(defun swap-set-key (key-map key-pairs)
  (mapc (lambda (kc) (define-key key-map (car kc) (cdr kc)))
        (mapcar (lambda (kp) (trans-bind key-map kp)) (append key-pairs (mapcar 'reverse-cons key-pairs)))))

(defconst qwerty-dvorak '(("b" . "h")
                          ("f" . "s")
                          ("p" . "t")))

(defun prefix-key-pair (from-prefix to-prefix key-pair)
  (cons (concat from-prefix (car key-pair)) (concat to-prefix (cdr key-pair))))

(defun dvorak-set-key (key-map)
  (let ((prefixes '((""       . "")
                    ("C-"     . "C-")
                    ("M-"     . "M-")
                    ("C-M-"   . "C-M-")
                    ("M-g M-" . "M-g M-")
                    )))
    (mapc (lambda (pp) (swap-set-key key-map (mapcar (lambda (kp) (prefix-key-pair (car pp) (cdr pp) kp)) qwerty-dvorak))) prefixes)))

(defun ncaq-set-key (key-map)
  (mapc (lambda (key) (define-key key-map (kbd key) 'nil)) '("C-o" "M-b" "C-M-b" "M-h" "C-M-h" "C-q" "M-q" "C-M-q"))
  (dvorak-set-key key-map))

(dvorak-set-key global-map)
(swap-set-key global-map '(("M-g p" . "M-g t")))

(ncaq-set-key isearch-mode-map)
(define-key isearch-mode-map (kbd "C-b") 'isearch-delete-char)
(define-key isearch-mode-map (kbd "M-b") 'isearc-del-char)
(define-key isearch-mode-map (kbd "M-m") 'isearch-exit-previous)

(ncaq-set-key minibuffer-local-map)

(with-eval-after-load 'ag (swap-set-key ag-mode-map '(("p" . "t"))))

(with-eval-after-load 'compile
  (ncaq-set-key compilation-minor-mode-map)
  (ncaq-set-key compilation-mode-map)
  (ncaq-set-key compilation-shell-minor-mode-map)
  )

(with-eval-after-load 'hexl
  (define-key hexl-mode-map (kbd "M-g") 'nil)
  (define-key hexl-mode-map [remap quoted-insert] 'hexl-quoted-insert)
  (ncaq-set-key hexl-mode-map)
  )

(with-eval-after-load 'comint    (ncaq-set-key comint-mode-map))
(with-eval-after-load 'diff-mode (ncaq-set-key diff-mode-map))
(with-eval-after-load 'doc-view  (ncaq-set-key doc-view-mode-map))
(with-eval-after-load 'help-mode (ncaq-set-key help-mode-map))
(with-eval-after-load 'info      (ncaq-set-key Info-mode-map))
(with-eval-after-load 'make-mode (ncaq-set-key makefile-mode-map))
(with-eval-after-load 'man       (ncaq-set-key Man-mode-map))
(with-eval-after-load 'prog-mode (ncaq-set-key prog-mode-map))
(with-eval-after-load 'prolog    (ncaq-set-key prolog-mode-map))
(with-eval-after-load 'rect      (ncaq-set-key rectangle-mark-mode-map))
