;;http://blog.goo.ne.jp/shihei_1951/e/cc8be74e8f330bb59539b30e4a234883
;;起動時の画面はいらない
(setq inhibit-startup-message)

(abbrev-mode -1)

(defun kill-scratch ()
  (kill-buffer "*scratch*"))
(add-hook 'after-init-hook 'kill-scratch);open-junk-fileがあるからscratchいらない
