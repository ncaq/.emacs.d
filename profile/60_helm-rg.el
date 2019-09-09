;; -*- lexical-binding: t -*-

;; helm-rgを使わない時は無いと言っても過言ではないのでちまちまautoloadせずrequireしてしまう
(require 'helm-rg)

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

(defun default-directory-is-git-dir? ()
  (eq 0 (call-process "git" nil nil nil "rev-parse" "--git-dir")))

(defun helm-rg-project-root (rg-pattern &optional pfx paths)
  (interactive (list (helm-rg--get-thing-at-pt) current-prefix-arg nil))
  (let ((helm-rg-default-directory 'git-root))
    (helm-rg rg-pattern pfx paths)))

(defun helm-rg-project-root-or-default (rg-pattern &optional pfx paths)
  (interactive (list (helm-rg--get-thing-at-pt) current-prefix-arg nil))
  (if (default-directory-is-git-dir?)
      (helm-rg-project-root rg-pattern pfx paths)
    (helm-rg rg-pattern pfx paths)))

(defun helm-rg-empty (&optional pfx paths)
  (interactive (list current-prefix-arg nil))
  (helm-rg "" pfx paths))

(defun helm-rg-project-root-empty (&optional pfx paths)
  (interactive (list current-prefix-arg nil))
  (helm-rg-project-root "" pfx paths))

(defun helm-rg-project-root-or-default-empty (&optional pfx paths)
  (interactive (list current-prefix-arg nil))
  (helm-rg-project-root-or-default "" pfx paths))

(swap-set-key helm-rg-map
              '(("M-b" . "M-u")
                ("M-g" . "M-l")
                ("M-d" . "M-i")
                ))
