;;http://blog.goo.ne.jp/shihei_1951/e/cc8be74e8f330bb59539b30e4a234883
;;起動時の画面はいらない
(setq inhibit-startup-message t)

(add-hook 'after-find-file (lambda ()(abbrev-mode nil)));auto-complete.el使うからいらない

(defun kill-scratch ()
  (kill-buffer "*scratch*"))
(add-hook 'after-init-hook 'kill-scratch);open-junk-fileがあるからscratchいらない
