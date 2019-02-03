;; -*- lexical-binding: t -*-

(with-eval-after-load 'ensime-startup
  (custom-set-variables '(ensime-startup-notification nil)))

(with-eval-after-load 'ensime-mode
  (define-key ensime-mode-map (kbd "M-n") nil)
  (define-key ensime-mode-map (kbd "M-p") nil)
  )
