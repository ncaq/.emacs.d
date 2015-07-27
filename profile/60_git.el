;; -*- lexical-binding: t -*-

(custom-set-variables
 '(fill-column 160)
 '(git-commit-fill-column 160)
 '(git-commit-summary-max-length 160)
 '(global-git-gutter+-mode t)
 )

(with-eval-after-load 'magit
  (define-key magit-mode-map (kbd "p") 'magit-tag-popup)
  (define-key magit-mode-map (kbd "t") 'magit-section-backward)

  (define-key magit-mode-map (kbd "M-h")   'nil)
  (define-key magit-mode-map (kbd "M-t")   'nil)
  (define-key magit-mode-map (kbd "M-n")   'nil)
  (define-key magit-mode-map (kbd "M-s")   'nil)
  (define-key magit-mode-map (kbd "M-p")   'nil)

  (define-key magit-mode-map (kbd "C-M-h") 'nil)
  (define-key magit-mode-map (kbd "C-M-s") 'nil)
  )
