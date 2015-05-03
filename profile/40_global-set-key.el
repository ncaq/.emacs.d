;; -*- lexical-binding: t -*-

(global-set-key (kbd "<tab>") 'indent-for-tab-command) ;何かしらを割り当てることで,C-iと別扱いになる

(global-set-key (kbd "C-'") 'auto-complete)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-,") 'mc/mark-all-dwim)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-.") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-;") 'toggle-input-method)
(global-set-key (kbd "C-=") 'text-scale-reset)
(global-set-key (kbd "C-^") 'dired-jump-to-current)
(global-set-key (kbd "C-a") 'smart-move-beginning-of-line)
(global-set-key (kbd "C-i") 'indent-whole-buffer)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-o") 'helm-for-files-lite)
(global-set-key (kbd "C-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-u") 'kill-whole-line)
(global-set-key (kbd "C-z") 'eww-goto-alc)

(global-set-key (kbd "C-\\") 'quoted-insert)

(global-set-key (kbd "C-S-b") 'smart-delete-whitespace-backward)
(global-set-key (kbd "C-S-d") 'delete-horizontal-space)
(global-set-key (kbd "C-S-m") 'quoted-newline)

(global-set-key (kbd "M-,") 'mc/edit-lines)
(global-set-key (kbd "M-c") 'help-command)
(global-set-key (kbd "M-l") 'sort-lines-auto-mark-paragrah)
(global-set-key (kbd "M-m") 'newline-under)
(global-set-key (kbd "M-o") 'helm-for-files)
(global-set-key (kbd "M-q") 'delete-other-windows)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-M-,") 'ag-regexp)
(global-set-key (kbd "C-M-;") 'align-space)
(global-set-key (kbd "C-M-d") 'kill-sexp)
(global-set-key (kbd "C-M-l") 'sort-lines-whole-buffer)
(global-set-key (kbd "C-M-m") 'newline-upper)
(global-set-key (kbd "C-M-o") 'ibuffer)
(global-set-key (kbd "C-M-q") 'kill-this-buffer)
(global-set-key (kbd "C-M-w") 'kill-ring-save-whole)

(global-set-key (kbd "C-M-S-q") 'kill-all-buffers)

(global-set-key (kbd "C-c ;") 'align-regexp)
(global-set-key (kbd "C-c a") 'text-adjust-selective)
(global-set-key (kbd "C-c b") 'eww)
(global-set-key (kbd "C-c c") 'quickrun)
(global-set-key (kbd "C-c l") 'recentf-cleanup)
(global-set-key (kbd "C-c n") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c o") 'open-junk-file)
(global-set-key (kbd "C-c p") 'tramp-cleanup-all-connections)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c t") 'google-translate-at-point)

(global-set-key (kbd "C-c C-f") 'ff-find-other-file)

(global-set-key (kbd "M-g b") 'magit-blame-mode)
(global-set-key (kbd "M-g d") 'vc-diff)
(global-set-key (kbd "M-g l") 'magit-file-log)
(global-set-key (kbd "M-g o") 'magit-show)
(global-set-key (kbd "M-g s") 'magit-status)

(global-set-key (kbd "C-x b") 'helm-buffers-list)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "<help> w") 'helm-man-woman)
