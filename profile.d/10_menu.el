;;menuを日本語化
;;https://forums.ubuntulinux.jp/viewtopic.php?id=3888
(setq menu-tree-coding-system 'utf-8)
(require 'menu-tree)

;; title bar にファイル名を表示
(setq frame-title-format "%f %Z %m %s")
;; tool bar を表示させない
(tool-bar-mode 0)
;; menu bar を表示させない
(menu-bar-mode 0)
