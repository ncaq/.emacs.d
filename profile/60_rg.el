;; -*- lexical-binding: t -*-

(with-eval-after-load 'rg (ncaq-set-key rg-mode-map))

(custom-set-variables '(helm-rg-default-directory 'git-root))

(with-eval-after-load 'helm-rg
  (swap-set-key helm-rg-map
                '(("M-b" . "M-u")
                  ("M-g" . "M-l")
                  ("M-d" . "M-i")
                  )))

(defun helm-rg-empty (&optional pfx paths)
  (interactive (list current-prefix-arg nil))
  (helm-rg "" pfx paths))

(defvar helm-rg-marker nil "helm-rgで遷移した場合のみマーキングするための変数")

(defun helm-rg-marker-save (&rest _)
  "マーカーを一時変数に保存"
  (setq helm-rg-marker (point-marker)))

(defun helm-rg-marker-push (_)
  "保存してあったマーカーを保存しますが,現在と同じ場合はキャンセルしたとみなして保存しません"
  (unless (equal helm-rg-marker (point-marker))
    (xref-push-marker-stack helm-rg-marker)))

(advice-add 'helm-rg :before 'helm-rg-marker-save)
(advice-add 'helm-rg--do-helm-rg :after 'helm-rg-marker-push)
