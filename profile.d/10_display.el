(require 'auto-complete);何故かないと時折バグる(再現性なし)
;;描画関係
(menu-bar-mode 0);menu bar を表示させない
(tool-bar-mode 0);tool bar を表示させない

;;タイトルバーにバッファ名を表示する
(setq frame-title-format (format "%%b"))

(auto-image-file-mode);画像表示

(require 'linum);;行番号を左に表示
(global-linum-mode)
;;auto-complete時に崩れる問題を修正
(defadvice linum-update
  (around tung/suppress-linum-update-when-popup activate)
  (unless (ac-menu-live-p)
    ad-do-it))
;;軽くする
;;http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

(require 'uniquify);;バッファの名前がかぶったらディレクトリ名もつける
(setq uniquify-buffer-name-style 'forward)

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
