;; -*- lexical-binding: t -*-

(global-set-key (kbd "<tab>") 'indent-for-tab-command) ;何かしらを割り当てることで,C-iと別扱いになる

(global-set-key (kbd "C-'") 'auto-complete)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-,") 'mc/mark-all-dwim)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-.") 'gtags-or-imenu)
(global-set-key (kbd "C-;") 'toggle-input-method)
(global-set-key (kbd "C-=") 'text-scale-reset)
(global-set-key (kbd "C-^") 'dired-jump-to-current)
(global-set-key (kbd "C-a") 'smart-move-beginning-of-line)
(global-set-key (kbd "C-b") 'backward-delete-char-untabify)
(global-set-key (kbd "C-i") 'indent-whole-buffer)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-o") 'helm-for-files-lite)
(global-set-key (kbd "C-p") 'other-window)
(global-set-key (kbd "C-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-u") 'kill-whole-line)

(global-set-key (kbd "C-\\") 'quoted-insert)

(global-set-key (kbd "C-S-b") 'smart-delete-whitespace-backward)
(global-set-key (kbd "C-S-d") 'smart-delete-whitespace-forward)
(global-set-key (kbd "C-S-m") 'quoted-newline)

(global-set-key (kbd "M-,") 'mc/edit-lines)
(global-set-key (kbd "M-.") 'pop-tag-mark)
(global-set-key (kbd "M-b") 'backward-kill-word)
(global-set-key (kbd "M-c") 'help-command)
(global-set-key (kbd "M-f") 'helm-occur)
(global-set-key (kbd "M-l") 'sort-lines-auto-mark-paragrah)
(global-set-key (kbd "M-m") 'newline-under)
(global-set-key (kbd "M-n") 'scroll-up-one)
(global-set-key (kbd "M-o") 'helm-for-files)
(global-set-key (kbd "M-q") 'delete-other-windows)
(global-set-key (kbd "M-t") 'scroll-down-one)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-M-,") 'ag-regexp)
(global-set-key (kbd "C-M--") 'eww-goto-alc)
(global-set-key (kbd "C-M-;") 'align-space)
(global-set-key (kbd "C-M-b") 'backward-kill-sexp)
(global-set-key (kbd "C-M-d") 'kill-sexp)
(global-set-key (kbd "C-M-l") 'sort-lines-whole-buffer)
(global-set-key (kbd "C-M-m") 'newline-upper)
(global-set-key (kbd "C-M-o") 'ibuffer)
(global-set-key (kbd "C-M-p") 'split-window-right)
(global-set-key (kbd "C-M-q") 'kill-this-buffer)
(global-set-key (kbd "C-M-w") 'kill-ring-save-whole)

(global-set-key (kbd "C-M-S-q") 'kill-all-buffers)

(global-set-key (kbd "C-c ;") 'align-regexp)
(global-set-key (kbd "C-c b") 'eww)
(global-set-key (kbd "C-c c") 'quickrun)
(global-set-key (kbd "C-c l") 'recentf-cleanup)
(global-set-key (kbd "C-c n") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c o") 'open-ncaq-working-dir)
(global-set-key (kbd "C-c p") 'tramp-cleanup-all-connections)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c w") 'whitespace-cleanup)

(global-set-key (kbd "C-c C-f") 'ff-find-other-file)

(global-set-key (kbd "M-g b") 'magit-blame)
(global-set-key (kbd "M-g d") 'vc-diff)
(global-set-key (kbd "M-g f") 'magit-find-file)
(global-set-key (kbd "M-g l") 'magit-log-buffer-file)
(global-set-key (kbd "M-g s") 'magit-status)

(global-set-key (kbd "C-x b") 'helm-buffers-list)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "<help> w") 'helm-man-woman)
