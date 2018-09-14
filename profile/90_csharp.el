;; -*- lexical-binding: t -*-

(custom-set-variables '(omnisharp-expected-server-version "1.32.5"))

(add-hook 'csharp-mode-hook 'omnisharp-mode)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-omnisharp))

(defun omnisharp-setup-ncaq ()
  (define-key omnisharp-mode-map (kbd "C-c C-a") 'omnisharp-run-code-action-refactoring)
  (define-key omnisharp-mode-map (kbd "C-c C-c") 'omnisharp-build-in-emacs)
  (define-key omnisharp-mode-map (kbd "C-c C-r") 'omnisharp-rename)
  (define-key omnisharp-mode-map (kbd "C-c C-s") 'omnisharp-start-omnisharp-server)
  (define-key omnisharp-mode-map (kbd "M-.") 'omnisharp-go-to-definition)
  )

(add-hook 'omnisharp-mode-hook 'omnisharp-setup-ncaq)
