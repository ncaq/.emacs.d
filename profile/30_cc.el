;; -*- lexical-binding: t -*-

(custom-set-variables
 '(c-default-style
   '((c-mode . "bsd")
     (c++-mode . "bsd")
     (java-mode . "bsd")
     (awk-mode . "awk")
     (other . "bsd")))
 '(c-basic-offset 4)
 )

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-M-h") 'nil)
  (define-key c-mode-base-map (kbd "C-M-j") 'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-M-q") 'nil)
  )

(with-eval-after-load 'flycheck
  (add-hook 'c++-mode-hook '(lambda ()
                              (custom-set-variables
                               '(flycheck-gcc-language-standard   "c++11")
                               '(flycheck-clang-language-standard "c++11")
                               '(flycheck-clang-standard-library  "libc++")
                               ))))

(with-eval-after-load 'gud
  (custom-set-variables
   '(gdb-many-windows t)                ;情報表示
   '(gud-tooltip-echo-area t)           ;mini bufferに値を表示
   '(gud-tooltip-mode t)                ;ポップアップで情報
   )
  (define-key gud-minor-mode-map (kbd "<f6>")  'gud-until)  ;現在の行まで実行
  (define-key gud-minor-mode-map (kbd "<f7>")  'gud-cont)   ;ブレークポイントまで実行
  (define-key gud-minor-mode-map (kbd "<f8>")  'gud-remove) ;ブレークポイント削除
  (define-key gud-minor-mode-map (kbd "<f9>")  'gud-break)  ;ブレークポイント設置
  (define-key gud-minor-mode-map (kbd "<f10>") 'gud-next)   ;1行進む
  (define-key gud-minor-mode-map (kbd "<f11>") 'gud-step)   ;1行進む.関数に入る
  (define-key gud-minor-mode-map (kbd "<f12>") 'gud-finish) ;step out 現在のスタックフレームを抜ける
  )
