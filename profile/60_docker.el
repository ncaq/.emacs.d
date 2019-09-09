;; -*- lexical-binding: t -*-

(custom-set-variables '(docker-container-shell-file-name "/bin/bash"))

(add-hook 'dockerfile-mode-hook 'eglot-ensure)
