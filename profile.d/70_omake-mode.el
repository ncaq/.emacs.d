;;C++で使え無い機能多いのでそれを無効化している
					; in .emacs:
(add-to-list 'load-path "~/.emacs.d/bigprogram.d/omake-mode/")
(require 'omake-mode)
(setq omake-program-path "/usr/bin/omake")
(setq omake-program-arguments "-P -w -j 3 --verbose")
					; omake command options. -w and --verbose are required for error browsing
(setq omake-error-highlight-background "#880000")

					; key bindings (jfuruse's setting)
;;(global-unset-key "\M-P") ; Shift+Alt+p 
;;(global-unset-key "\M-N") ; Shift+Alt+n
(global-unset-key "\M-o") ; Alt+o
(global-unset-key "\M-O") ; Shift+Alt+o
(global-unset-key [(control shift o)]) ; Ctrl+Shift+o

(global-set-key "\M-O" 'omake-run)
					; launch a new omake process in the current buffer's directory

(global-set-key [(control shift o)] 'omake-rerun)
					; restart omake process of the current omake buffer

;;(global-set-key "\M-P" 'omake-previous-error)
;;(global-set-key "\M-N" 'omake-next-error)
					; visit the previous/next error of the current omake window

(global-set-key "\M-o" 'omake-round-visit-buffer)
					; visit another omake process window

					; aother possibilities
(global-unset-key [M-up])
(global-unset-key [M-down])
(global-set-key [M-up] 'omake-previous-error)
(global-set-key [M-down] 'omake-next-error)
