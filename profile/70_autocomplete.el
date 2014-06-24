;; -*- lexical-binding: t -*-
;;http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode)

(custom-set-variables
 '(ac-auto-start nil);自動で補完画面を出すならt.補完キーを押すまで補完画面を出さないならnil.数字なら文字数.
 '(ac-ignore-case);大文字・小文字を区別しない
 '(ac-menu-height 22);補完列表示数
 '(ac-quick-help-delay);ヘルプを即表示
 '(ac-use-quick-help));ヘルプを表示

(setq-default ac-sources '(ac-source-files-in-current-dir ac-source-dictionary ac-source-words-in-all-buffer));デフォルトの情報源を指定

(custom-set-variables '(ac-modes (append
                                  '(conf-mode
                                    conf-space-mode
                                    d-mode
                                    fundamental-mode
                                    haskell-mode
                                    inferior-haskell-mode
                                    latex-mode
                                    markdown-mode
                                    processing-mode
                                    shell-script-mode
                                    text-mode)
                                  ac-modes)))

(ac-set-trigger-key "TAB")
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-t") 'ac-previous)
(define-key ac-mode-map       (kbd "C-'") 'auto-complete)
