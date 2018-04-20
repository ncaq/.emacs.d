;; -*- lexical-binding: t -*-

(custom-set-variables
 '(dired-auto-revert-buffer t)          ;diredの自動再読込
 '(dired-dwim-target t)
 '(dired-isearch-filenames t)
 '(dired-listing-switches
   (concat "-Fhval" (when (string-prefix-p "gnu" (symbol-name system-type))
                      " --group-directories-first")))
 )

(with-eval-after-load 'dired
  (defun dired-jump-to-current ()
    (interactive)
    (dired "."))

  (ncaq-set-key dired-mode-map)
  (define-key dired-mode-map (kbd "C-o") 'nil)
  (define-key dired-mode-map (kbd "C-p") 'nil)
  (define-key dired-mode-map (kbd "M-o") 'nil)
  (define-key dired-mode-map (kbd "C-^") 'dired-up-directory)
  (define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode)
  )
