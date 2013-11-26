(require 'google-translate)

(custom-set-variables
  '(google-translate-default-source-language "en")
  '(google-translate-default-target-language "ja"))

(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse)
