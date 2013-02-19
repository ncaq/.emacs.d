;;http://www.02.246.ne.jp/~torutk/cxx/emacs/mode_extension.html

(require 'autoinsert)
;; テンプレート格納用ディレクトリ
(setq auto-insert-directory "~/.emacs.d/insert/")
;; ファイル拡張子とテンプレートの対応
(setq auto-insert-alist
      (append '(
		("\\.cpp$" . ["template.cpp" my-template])
		("\\.hpp$" . ["template.hpp" my-template])
		) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)

(eval-when-compile (require 'cl))
(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () 
			      (setq file-without-ext (file-name-sans-extension
						      (file-name-nondirectory (buffer-file-name))))))
    ("%namespace%" .
     (lambda () (setq namespace (read-from-minibuffer "namespace: "))))
    ("%include%" .
     (lambda () 
       (cond ((string= namespace "") (concat "\"" file-without-ext ".hpp\""))
	     (t (concat "<" (replace-regexp-in-string "::" "/" namespace) "/"
			file-without-ext ".hpp>")))))
    ("%name%" . user-full-name)
    ("%mail%" . (lambda () (identity user-mail-address)))
    ("%time%" . (lambda () (current-time-string)))
    ("%bdesc%" . (lambda () (read-from-minibuffer "Brief description: ")))
    ("%namespace-open%" .
     (lambda ()
       (cond ((string= namespace "") "")
	     (t (progn 
		  (setq namespace-list (split-string namespace "::"))
		  (setq namespace-text "")
		  (while namespace-list
		    (setq namespace-text (concat namespace-text "namespace "
                                                 (car namespace-list) " {\n"))
		    (setq namespace-list (cdr namespace-list))
		    )
		  (eval namespace-text))))))
    ("%namespace-close%" .
     (lambda ()
       (cond ((string= namespace "") "")
	     (t (progn
		  (setq namespace-list (reverse (split-string namespace "::")))
		  (setq namespace-text "")
		  (while namespace-list
		    (setq namespace-text (concat namespace-text "} // " (car namespace-list) "\n"))
		    (setq namespace-list (cdr namespace-list))
		    )
		  (eval namespace-text))))))
    ))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

(add-hook 'find-file-not-found-hooks 'auto-insert)
