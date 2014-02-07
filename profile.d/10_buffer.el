;;フォント
(set-face-attribute 'default nil :family "Ricty" :height 180)

;;package-listのformat
(define-derived-mode package-menu-mode tabulated-list-mode "Package Menu"
  "Major mode for browsing a list of packages.
Letters do not insert themselves; instead, they are commands.
\\<package-menu-mode-map>
\\{package-menu-mode-map}"
  (setq tabulated-list-format [("Package" 35 package-menu--name-predicate)
			       ("Version" 15 package-menu--version-predicate)
			       ("Status"  10 package-menu--status-predicate)
			       ("Description" 10 package-menu--description-predicate)])
  (setq tabulated-list-padding 1)
  (setq tabulated-list-sort-key (cons "Status" nil))
  (tabulated-list-init-header))

;;ibufferのformat
(require 'ibuffer)
(setq ibuffer-formats
      '((mark modified read-only " " (name 60 30)
	      " " (size 6 -1) " " (mode 16 16) " " filename)
	(mark " " (name 60 -1) " " filename)))
