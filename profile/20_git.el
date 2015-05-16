;; -*- lexical-binding: t -*-

(custom-set-variables
 '(fill-column 160)
 '(git-commit-fill-column 160)
 '(git-commit-mode-hook nil)
 '(git-commit-summary-max-length 160)
 '(global-git-gutter+-mode t)
 '(magit-diff-refine-hunk 'all)
 )

(setq magit-last-seen-setup-instructions "1.4.0")

(with-eval-after-load 'magit
  (define-key magit-mode-map (kbd "p") 'magit-key-mode-popup-tagging)
  (define-key magit-mode-map (kbd "t") 'magit-goto-previous-section)

  (define-key magit-mode-map (kbd "M-h")   'nil)
  (define-key magit-mode-map (kbd "M-t")   'nil)
  (define-key magit-mode-map (kbd "M-n")   'nil)
  (define-key magit-mode-map (kbd "M-s")   'nil)
  (define-key magit-mode-map (kbd "M-p")   'nil)

  (define-key magit-mode-map (kbd "C-M-h") 'nil)
  (define-key magit-mode-map (kbd "C-M-t") 'magit-goto-previous-sibling-section)
  (define-key magit-mode-map (kbd "C-M-n") 'magit-goto-next-sibling-section)
  (define-key magit-mode-map (kbd "C-M-s") 'nil)
  )
