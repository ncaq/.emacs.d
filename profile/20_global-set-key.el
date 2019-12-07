;; -*- lexical-binding: t -*-

;; 何かしらを割り当てることで,C-iと別扱いになる
(global-set-key (kbd "<tab>") 'indent-for-tab-command)

(global-set-key (kbd "C-'") 'mc/mark-all-dwim)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-;") 'toggle-input-method)
(global-set-key (kbd "C-=") 'text-scale-reset)
(global-set-key (kbd "C-^") 'dired-jump-to-current)
(global-set-key (kbd "C-a") 'smart-move-beginning-of-line)
(global-set-key (kbd "C-b") 'backward-delete-char-untabify)
(global-set-key (kbd "C-i") 'indent-whole-buffer)
(global-set-key (kbd "C-j") 'helm-do-ag-project-root-or-default)
(global-set-key (kbd "C-o") 'helm-for-files)
(global-set-key (kbd "C-p") 'other-window-fallback-split)
(global-set-key (kbd "C-q") 'kill-this-buffer)
(global-set-key (kbd "C-u") 'kill-whole-line)
(global-set-key (kbd "C-w") 'kill-region-or-word-at-point)
(global-set-key (kbd "C-z") 'flycheck-list-errors)

(global-set-key (kbd "<C-iso-lefttab>") 'company-dabbrev)
(global-set-key (kbd "C-<tab>")         'company-complete)
(global-set-key (kbd "C-\\")            'quoted-insert)

(global-set-key (kbd "C-S-b") 'smart-delete-whitespace-backward)
(global-set-key (kbd "C-S-d") 'smart-delete-whitespace-forward)
(global-set-key (kbd "C-S-m") 'quoted-newline)

(global-set-key (kbd "M-'") 'mc/edit-lines)
(global-set-key (kbd "M-b") 'backward-kill-word)
(global-set-key (kbd "M-c") 'help-command)
(global-set-key (kbd "M-f") 'helm-occur)
(global-set-key (kbd "M-j") 'helm-do-ag-project-root-or-default-at-point)
(global-set-key (kbd "M-l") 'sort-dwim)
(global-set-key (kbd "M-m") 'newline-under)
(global-set-key (kbd "M-n") 'scroll-up-one)
(global-set-key (kbd "M-o") 'helm-multi-files)
(global-set-key (kbd "M-p") 'other-window-backward)
(global-set-key (kbd "M-q") 'delete-other-windows)
(global-set-key (kbd "M-r") 'revert-buffer-safe-confirm)
(global-set-key (kbd "M-t") 'scroll-down-one)
(global-set-key (kbd "M-u") 'copy-whole-line)
(global-set-key (kbd "M-w") 'kill-ring-save-region-or-word-at-point)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-z") 'flycheck-compile)

(global-set-key (kbd "C-M-;") 'align-space)
(global-set-key (kbd "C-M-b") 'backward-kill-sexp)
(global-set-key (kbd "C-M-d") 'kill-sexp)
(global-set-key (kbd "C-M-j") 'helm-do-ag)
(global-set-key (kbd "C-M-l") 'sort-lines-whole-buffer)
(global-set-key (kbd "C-M-m") 'newline-upper)
(global-set-key (kbd "C-M-o") 'ibuffer)
(global-set-key (kbd "C-M-p") 'split-window-dwim-and-other)
(global-set-key (kbd "C-M-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-M-w") 'copy-to-register-@)
(global-set-key (kbd "C-M-y") 'yank-register-@)

(global-set-key (kbd "C-M-S-q") 'kill-file-or-dired-buffers)

(global-set-key (kbd "C-c ;") 'align-regexp)
(global-set-key (kbd "C-c a") 'open-downloads)
(global-set-key (kbd "C-c c") 'quickrun)
(global-set-key (kbd "C-c e") 'open-ncaq-entry)
(global-set-key (kbd "C-c j") 'rg)
(global-set-key (kbd "C-c l") 'recentf-cleanup)
(global-set-key (kbd "C-c n") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c o") 'open-desktop)
(global-set-key (kbd "C-c p") 'tramp-cleanup-all-connections)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c u") 'open-document-current)

(global-set-key (kbd "C-x d") 'mark-defun)
(global-set-key (kbd "C-x g") 'insert-random-uuid)
(global-set-key (kbd "C-x p") 'mark-paragraph)
(global-set-key (kbd "C-x t") 'insert-iso-datetime)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "M-g b") 'magit-blame)
(global-set-key (kbd "M-g d") 'magit-diff)
(global-set-key (kbd "M-g f") 'magit-find-file)
(global-set-key (kbd "M-g g") 'magit-dispatch-popup)
(global-set-key (kbd "M-g l") 'magit-log-buffer-file)
(global-set-key (kbd "M-g s") 'magit-status)

(global-set-key (kbd "<help> w") 'helm-man-woman)

(global-set-key (kbd "C-x <RET> s") (lambda () (interactive) (revert-buffer-with-coding-system 'japanese-cp932-dos)))

(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
