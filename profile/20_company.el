;; -*- lexical-binding: t -*-

(custom-set-variables
 '(global-company-mode t)
 '(company-backends (list
                     'company-clang
                     'company-cmake
                     'company-css
                     'company-nxml
                     'company-gtags
                     'company-etags
                     'company-keywords
                     'company-capf
                     'company-semantic
                     'company-files
                     'company-dabbrev
                     ))
 '(company-dabbrev-minimum-length 2)
 )

(with-eval-after-load 'company
  (defun company-trigger-key-command ()
    (interactive)
    (if (eq last-command 'self-insert-command)
        (company-complete-common)
      (indent-for-tab-command)))

  (define-key company-active-map (kbd "C-'") 'company-complete-common)

  (define-key company-active-map (kbd "C-s") 'nil)
  (define-key company-active-map (kbd "C-f") 'company-search-candidates)

  (define-key company-active-map (kbd "C-h") 'nil)
  (define-key company-active-map (kbd "M--") 'company-show-doc-buffer)

  (define-key company-active-map (kbd "M-p") 'nil)
  (define-key company-active-map (kbd "M-t") 'company-select-previous)
  )
