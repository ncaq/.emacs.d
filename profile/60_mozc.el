(require 'mozc)
(setq default-input-method 'japanese-mozc)
(setq mozc-candidate-style 'echo-area)
(global-set-key (kbd "C-;") 'toggle-input-method)
