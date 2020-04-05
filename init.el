;; -*- lexical-binding: t -*-

;; load-pathに野良submoduleを追加する
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list (concat user-emacs-directory "module/")))

(eval-and-compile
  (prog1 "leafを初期化する"
    (custom-set-variables
     '(package-archives '(("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize)
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf))
    (leaf leaf-keywords
      :ensure t
      :config (leaf-keywords-init))))

(leaf cus-edit :custom (custom-file . "~/.emacs.d/custom.el")) ; init.elに設定ファイルを書き込ませない

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  "バッファが存在すればkillする,無ければ何もしない."
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

;; 起動時に作られる使わないバッファを削除する
(kill-buffer-if-exist "*scratch*")

(defun open-desktop ()
  (interactive)
  (find-file "~/Desktop/"))

(defun open-downloads ()
  (interactive)
  (find-file "~/Downloads/"))

(defun open-document-current ()
  (interactive)
  (let ((find-file-visit-truename t))
    (find-file "~/Documents/current/")))

(defun open-ncaq-entry ()
  (interactive)
  (find-file (concat "~/Desktop/www.ncaq.net/entry/"
                     (format-time-string "%Y-%m-%d-%H-%M-%S" (current-time)) ".md")))

(defun insert-iso-datetime ()
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S%:z" (current-time))))

(leaf s
  :ensure t
  :require t
  :defun s-trim
  :config
  (defun insert-random-uuid ()
    (interactive)
    (insert (s-trim (shell-command-to-string "uuidgen")))))

(defun revert-buffer-with-coding-system-japanese-cp932-dos ()
  (interactive)
  (revert-buffer-with-coding-system 'japanese-cp932-dos))

(leaf server
  :require t
  :defun server-running-p
  :config (unless (server-running-p) (server-start)))

;; Dvorak設定をするための関数
(defun reverse-cons (c)
  (cons (cdr c) (car c)))

(defun trans-bind (key-map key-pair)
  (cons (kbd (car key-pair)) (command-or-nil (lookup-key key-map (kbd (cdr key-pair))))))

(defun command-or-nil (symbol)
  (when (commandp symbol) symbol))

(defun swap-set-key (key-map key-pairs)
  (mapc
   (lambda (kc)
     (define-key key-map (car kc) (cdr kc)))
   (mapcar
    (lambda (kp)
      (trans-bind key-map kp))
    (append key-pairs (mapcar 'reverse-cons key-pairs)))))

(defconst qwerty-dvorak '(("b" . "h")
                          ("f" . "s")
                          ("p" . "t")))

(defun prefix-key-pair (from-prefix to-prefix key-pair)
  (cons (concat from-prefix (car key-pair)) (concat to-prefix (cdr key-pair))))

(defun dvorak-set-key (key-map)
  (let ((prefixes '((""       . "")
                    ("C-"     . "C-")
                    ("M-"     . "M-")
                    ("C-M-"   . "C-M-")
                    ("M-g M-" . "M-g M-")
                    )))
    (mapc
     (lambda (pp)
       (swap-set-key key-map (mapcar
                              (lambda (kp)
                                (prefix-key-pair (car pp) (cdr pp) kp))
                              qwerty-dvorak)))
     prefixes)))

(defun ncaq-set-key (key-map)
  (swap-set-key key-map '(("M-h" . "C-x p") ("C-M-h" . "C-x d")))
  (mapc
   (lambda (key)
     (define-key key-map (kbd key) 'nil))
   '("C-o" "M-b" "C-M-b" "C-q" "M-q" "C-M-q"))
  (dvorak-set-key key-map))

;; 分割できないDvorak設定
(dvorak-set-key global-map)
(swap-set-key global-map '(("M-g p" . "M-g t")))

;; minibuffer-local-map is a variable defined in `C source code'.
(ncaq-set-key minibuffer-local-map)

(leaf isearch
  :bind (:isearch-mode-map
         ("C-b" . isearch-delete-char)
         ("M-b" . isearc-del-char)
         ("M-m" . isearch-exit-previous)
         )
  :config (ncaq-set-key isearch-mode-map))

(leaf popup
  :ensure t
  ;; 何故か`popup-close'などは`interactive'ではないため自前で書いて強制的に書き換える
  ;; 何故`interactive'じゃないのに動くんでしょう…
  :bind (:popup-menu-keymap
         ("C-f" . popup-isearch)
         ("C-b" . nil)
         ("C-p" . nil)
         ("C-t" . popup-previous)
         ("C-s" . popup-open)
         ))

(leaf compile
  :after t
  :defvar compilation-minor-mode-map compilation-mode-map compilation-shell-minor-mode-map
  :config
  (ncaq-set-key compilation-minor-mode-map)
  (ncaq-set-key compilation-mode-map)
  (ncaq-set-key compilation-shell-minor-mode-map))

(leaf hexl
  :bind (:hexl-mode-map
         ("M-g" . nil)
         ([remap quoted-insert] . hexl-quoted-insert)
         )
  :config (ncaq-set-key hexl-mode-map))

(leaf info      :after t :config (ncaq-set-key Info-mode-map))
(leaf prog-mode :after t :config (ncaq-set-key prog-mode-map))

(leaf comint    :after t :defvar comint-mode-map         :config (ncaq-set-key comint-mode-map))
(leaf diff-mode :after t :defvar diff-mode-map           :config (ncaq-set-key diff-mode-map))
(leaf doc-view  :after t :defvar doc-view-mode-map       :config (ncaq-set-key doc-view-mode-map))
(leaf help-mode :after t :defvar help-mode-map           :config (ncaq-set-key help-mode-map))
(leaf rect      :after t :defvar rectangle-mark-mode-map :config (ncaq-set-key rectangle-mark-mode-map))

;; global-set-key
(leaf *global-set-key
  :bind
  (("<tab>" . indent-for-tab-command) ; 何かしらを割り当てることで, C-iと別扱いになる

   ("C-'" . mc/mark-all-dwim)
   ("C-+" . text-scale-increase)
   ("C-," . my-string-inflection-cycle-auto)
   ("C--" . text-scale-decrease)
   ("C-;" . toggle-input-method)
   ("C-=" . text-scale-reset)
   ("C-^" . dired-jump-to-current)
   ("C-a" . smart-move-beginning-of-line)
   ("C-b" . backward-delete-char-untabify)
   ("C-i" . indent-whole-buffer)
   ("C-j" . helm-do-ag-project-root-or-default)
   ("C-o" . helm-for-files)
   ("C-p" . other-window-fallback-split)
   ("C-q" . kill-this-buffer)
   ("C-u" . kill-whole-line)
   ("C-w" . kill-region-or-word-at-point)
   ("C-z" . flycheck-list-errors)

   ("<C-iso-lefttab>" . company-dabbrev)
   ("C-<tab>" .         company-complete)
   ("C-\\" .            quoted-insert)

   ("C-S-b" . smart-delete-whitespace-backward)
   ("C-S-d" . smart-delete-whitespace-forward)
   ("C-S-m" . quoted-newline)

   ("M-'" . mc/edit-lines)
   ("M-b" . backward-kill-word)
   ("M-c" . help-command)
   ("M-f" . helm-occur)
   ("M-j" . helm-do-ag-project-root-or-default-at-point)
   ("M-l" . sort-dwim)
   ("M-m" . newline-under)
   ("M-n" . scroll-up-one)
   ("M-o" . helm-multi-files)
   ("M-p" . other-window-backward)
   ("M-q" . delete-other-windows)
   ("M-r" . revert-buffer-safe-confirm)
   ("M-t" . scroll-down-one)
   ("M-u" . copy-whole-line)
   ("M-w" . kill-ring-save-region-or-word-at-point)
   ("M-x" . helm-M-x)
   ("M-y" . helm-show-kill-ring)
   ("M-z" . flycheck-compile)

   ("C-M-;" . align-space)
   ("C-M-b" . backward-kill-sexp)
   ("C-M-d" . kill-sexp)
   ("C-M-j" . helm-do-ag-current-dir)
   ("C-M-l" . sort-lines-whole-buffer)
   ("C-M-m" . newline-upper)
   ("C-M-o" . ibuffer)
   ("C-M-p" . split-window-dwim-and-other)
   ("C-M-q" . kill-buffer-and-window)
   ("C-M-w" . copy-to-register-@)
   ("C-M-y" . yank-register-@)

   ("C-M-S-q" . kill-file-or-dired-buffers)

   ("C-c ;" . align-regexp)
   ("C-c a" . open-downloads)
   ("C-c c" . quickrun)
   ("C-c e" . open-ncaq-entry)
   ("C-c j" . rg)
   ("C-c l" . recentf-cleanup)
   ("C-c o" . open-desktop)
   ("C-c p" . tramp-cleanup-all-connections)
   ("C-c u" . open-document-current)

   ("C-x d" . mark-defun)
   ("C-x g" . insert-random-uuid)
   ("C-x p" . mark-paragraph)
   ("C-x t" . insert-iso-datetime)

   ("C-x C-f" . helm-find-files)

   ("M-g b" . magit-blame)
   ("M-g d" . magit-diff)
   ("M-g f" . magit-find-file)
   ("M-g g" . magit-dispatch-popup)
   ("M-g l" . magit-log-buffer-file)
   ("M-g s" . magit-status)

   ("<help> w" . helm-man-woman)

   ("C-x <RET> s" . revert-buffer-with-coding-system-japanese-cp932-dos)

   ([remap query-replace] . anzu-query-replace)
   ([remap query-replace-regexp] . anzu-query-replace-regexp)
   ))

;; 見た目
;; 等幅になるようにRictyを設定
(leaf faces :config (set-face-attribute 'default nil :family "Ricty" :height 135))
(leaf *set-fontset-font :config (set-fontset-font t 'unicode (font-spec :name "Ricty") nil 'append))

;; シンタックスハイライトをグローバルで有効化
(leaf font-core :config (global-font-lock-mode 1))

;; テーマを読み込む
(leaf solarized-theme :ensure t :config (load-theme 'solarized-dark t))

;; 以下の順番で読み込まないと正常に動かなかった
;; rainbow-delimiters -> rainbow-mode

;; 括弧の対応を色対応でわかりやすく
(leaf rainbow-delimiters
  :ensure t
  :hook
  prog-mode-hook
  web-mode-hook
  :config (set-face-foreground 'rainbow-delimiters-depth-1-face "#586e75")) ;文字列の色と被るため,変更

;; 色コードを可視化
(leaf rainbow-mode
  :ensure t
  :hook
  css-mode-hook
  emacs-lisp-mode-hook
  hamlet-mode-hook
  help-mode-hook
  lisp-mode-hook
  sass-mode-hook
  scss-mode-hook
  web-mode-hook
  )

;; カットペーストなど挿入削除時にハイライト
(leaf volatile-highlights :ensure t :config (volatile-highlights-mode t))

;; 置換の動きを可視化
(leaf anzu :ensure t :config (global-anzu-mode t))

;; History
(leaf recentf
  :custom
  ((recentf-max-saved-items . 2000)
   (recentf-auto-cleanup . 600)
   (recentf-exclude . '("\\.elc$" "\\.o$" "~$" "\\.file-backup/" "\\.undo-tree/" "EDITMSG" "PATH" "TAGS" "autoloads"))))

(leaf recentf-ext
  :ensure t
  :require t)

(leaf recentf-remove-sudo-tramp-prefix
  :ensure t
  :config (recentf-remove-sudo-tramp-prefix-mode 1))

(leaf savehist
  :custom
  ((savehist-mode . t)
   (savehist-minibuffer-history-variables . (cons 'extended-command-history savehist-minibuffer-history-variables))))

(leaf desktop
  :custom
  ((desktop-save-mode . t)
   (desktop-globals-to-save . nil)
   (desktop-restore-frames . nil)))

(leaf save-place-mode :config (save-place-mode 1))

(leaf files
  :custom
  (;; バックアップ先をカレントディレクトリから変更
   (backup-directory-alist . `(("" . ,(concat user-emacs-directory "file-backup/"))))
   ;; 自動保存(クラッシュ時の対応)先をカレントディレクトリから変更
   (auto-save-file-name-transforms . `((".*" ,temporary-file-directory t)))
   ;; askだと件数を超えた自動削除時時に一々聞いてくるのでtに変更
   (delete-old-versions . t)
   ;; backupに新しいものをいくつ残すか
   (kept-new-versions . 50)
   ;; backupに古いものをいくつ残すか
   (kept-old-versions . 0)
   ;; バックアップファイルを作成する。
   (make-backup-files . t)
   ;; 複数バックアップ
   (version-control . t)
   ))

(leaf tramp :custom (tramp-auto-save-directory . temporary-file-directory)) ; trampの自動保存ディレクトリをtmpにする
(leaf *history
  :custom (create-lockfiles . nil)      ; ロックファイルとしてシンボリックリンクを作らない. parcelがバグる.
  :config
  (defun setq-buffer-backed-up-nil (&rest _) (interactive) (setq buffer-backed-up nil))
  (advice-add 'save-buffer :before 'setq-buffer-backed-up-nil))

;; toolkit
(leaf menu-bar :custom (menu-bar-mode . nil))          ; メニューバーを表示させない
(leaf tool-bar :custom (tool-bar-mode . nil))          ; ツールバーを表示させない
(leaf frame :config (toggle-frame-maximized))        ; 全画面化
(leaf image-file :custom (auto-image-file-mode . 1)) ; 画像を表示

(leaf bindings
  :config
  ;; ((ファイル名 or バッファ名) モード一覧)
  (setq frame-title-format '(:eval (list (or (buffer-file-name) (buffer-name)) " " mode-line-modes)))
  ;; mode-line line and column and sum char numbar
  (setq mode-line-position
        '(:eval
          (list
           "l%l/"
           (number-to-string (count-lines (point-min) (point-max)))
           " c"
           (number-to-string (- (point) (line-beginning-position)))
           "/"
           (number-to-string (- (line-end-position) (line-beginning-position)))
           " s"
           (number-to-string (point))
           "/%i"
           ))))

;; バッファの名前にディレクトリ名を付けることでユニークになりやすくする
(leaf uniquify
  :require t
  :custom (uniquify-buffer-name-style . 'forward))

;; toolkit end

(leaf tabulated-list
  :config
  (define-derived-mode package-menu-mode tabulated-list-mode "Package Menu"
    "Major mode for browsing a list of packages.
Letters do not insert themselves; instead, they are commands.
\\<package-menu-mode-map>
\\{package-menu-mode-map}"
    (setq tabulated-list-format
          [("Package" 35 package-menu--name-predicate)
           ("Version" 15 package-menu--version-predicate)
           ("Status"  10 package-menu--status-predicate)
           ("Description" 10 package-menu--description-predicate)])
    (setq tabulated-list-padding 1)
    (setq tabulated-list-sort-key (cons "Status" nil))
    (tabulated-list-init-header)))

(leaf dired
  :require t
  :preface (defvar ls-option (concat "-Fhval" (when (string-prefix-p "gnu" (symbol-name system-type)) " --group-directories-first")))
  :custom ((dired-auto-revert-buffer . t) ; diredの自動再読込
           (dired-dwim-target . t)
           (dired-isearch-filenames . t)
           (dired-listing-switches . ls-option)
           (dired-recursive-copies . 'always)  ; 聞かずに再帰的コピー
           (dired-recursive-deletes . 'always) ; 聞かずに再帰的削除
           )
  :config
  (defun dired-jump-to-current ()
    (interactive)
    (dired "."))
  (leaf wdired
    :require t
    :bind (:dired-mode-map
           ("C-o" . nil)
           ("C-p" . nil)
           ("M-o" . nil)
           ("C-^" . dired-up-directory)
           ("C-c C-p" . wdired-change-to-wdired-mode)
           )
    :config (ncaq-set-key dired-mode-map)))

(leaf *c-source-code
  :custom
  ((delete-by-moving-to-trash . t)      ; ごみ箱を有効
   (fill-column . 1000)                 ; auto fillを実質無効化(ちゃんとした無効化方法がわからない)
   (indent-tabs-mode . nil)             ; インデントをスペースで行う
   (message-log-max . 100000)           ; メッセージをたくさん残す
   (read-buffer-completion-ignore-case . t) ; 大文字と小文字を区別しない バッファ名
   (read-file-name-completion-ignore-case . t) ; 大文字と小文字を区別しない ファイル名
   (scroll-conservatively . 1) ; 最下段までスクロールした時のカーソルの移動量を減らす
   (scroll-margin . 5)    ; 最下段までスクロールしたという判定を伸ばす
   ))

(leaf man
  :after t
  :defvar Man-mode-map
  :custom (Man-notify-method . 'bully)  ; Manページを現在のウィンドウで表示
  :config (ncaq-set-key Man-mode-map))

(leaf ediff
  :config
  :custom
  ((ediff-split-window-function . 'split-window-horizontally)   ; ediffでウィンドウを横分割
   (ediff-window-setup-function . 'ediff-setup-windows-plain))) ; ediffにframeを生成させない

(leaf autorevert :custom (global-auto-revert-mode . 1)) ; 自動再読込
(leaf diff :custom (diff-switches . "-u")) ; diffをunifitedモードで
(leaf executable :config (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)) ; スクリプトに実行権限付加
(leaf files :custom (require-final-newline . t)) ; ファイルの最後に改行
(leaf imaxima :custom (imaxima-scale-factor . 10.0)) ; imaximaの全体を大きくする
(leaf indent :custom (standard-indent . 2)) ; 標準インデント値を出来るだけ2にする
(leaf novice :custom (disabled-command-function . nil)) ; 初心者向けに無効にされているコマンドを有効にする
(leaf scheme :custom (scheme-program-name . "gosh")) ; schemeの処理系をgaucheに
(leaf select :custom (select-enable-clipboard . t)) ; クリップボードをX11と共有
(leaf simple :custom (blink-matching-paren . nil)) ; 括弧移動無効
(leaf startup :custom (inhibit-startup-screen . t)) ; スタートアップ画面を出さない
(leaf subr :config (fset 'yes-or-no-p 'y-or-n-p)) ; "yes or no"を"y or n"に
(leaf vc-hooks :custom (vc-follow-symlinks . t)) ; 常にシンボリックリンクをたどる
(leaf warnings :custom (warning-minimum-level . :error)) ; 警告はエラーレベルでないとポップアップ表示しない

(leaf ibuffer
  :after t
  :defvar ibuffer-mode-map
  :preface (defvar ibuffer-formats-conf
             '((mark modified read-only " " (name 60 30) " " (size 6 -1) " " (mode 16 16) " " filename)
               (mark " " (name 60 -1) " " filename)))
  :custom (ibuffer-formats . ibuffer-formats-conf)
  :config
  (define-key ibuffer-mode-map (kbd "M-g") 'nil)
  (ncaq-set-key ibuffer-mode-map)
  (define-key ibuffer-mode-map (kbd "C-o") 'nil)
  (define-key ibuffer-mode-map (kbd "C-p") 'nil)
  )

(leaf profiler
  :after t
  :defvar profiler-report-mode-map profiler-report-cpu-line-format
  :config
  (ncaq-set-key profiler-report-mode-map)
  (setq profiler-report-cpu-line-format '((100 left) (24 right ((19 right) (5 right))))))

(leaf company
  :ensure t
  :require t
  :defvar company-search-map
  :custom ((company-dabbrev-code-other-buffers . 'all) (company-dabbrev-downcase . nil) (company-dabbrev-other-buffers . 'all))
  :bind (:company-active-map
         ("<backtab>" . company-select-previous)
         ("<tab>" . company-complete-common-or-cycle))
  :config
  (global-company-mode 1)
  (ncaq-set-key company-active-map)
  (define-key company-active-map (kbd"C-b") 'nil)
  (dvorak-set-key company-search-map)
  (leaf company-quickhelp
    :ensure t
    :require t
    :config
    (company-quickhelp-mode 1)))

(leaf helm
  :ensure t
  :require t helm-config
  :custom ((helm-buffer-max-len-mode . 25) ; モードを短縮する基準
           (helm-buffer-max-length . 50)   ; デフォルトはファイル名を短縮する区切りが20
           (helm-delete-minibuffer-contents-from-point . t) ; kill-line sim
           (helm-descbinds-mode . t)
           (helm-ff-file-name-history-use-recentf . t)
           (helm-samewindow . t)        ; ウインドウ全体に表示
           (helm-for-files-preferred-list . '(helm-source-buffers-list
                                              helm-source-recentf
                                              helm-source-files-in-current-dir
                                              helm-source-ls-git-status
                                              helm-source-ls-git
                                              helm-source-file-cache
                                              helm-source-locate
                                              )))
  :bind (:helm-map ("C-M-b" . nil) ("C-b" . nil) ("C-h" . nil) ("M-b" . nil) ("M-s" . nil) ("<tab>" . helm-select-action))
  :config
  (helm-mode 1)
  (custom-set-variables '(helm-boring-buffer-regexp-list (append '("\\*Flymake" "\\*tramp") helm-boring-buffer-regexp-list)))
  (swap-set-key
   helm-map
   '(("C-t" . "C-p")
     ("C-s" . "C-f")))
  (leaf helm-buffers :bind (:helm-buffer-map ("C-s" . nil)))
  (leaf helm-files :bind (:helm-find-files-map ("C-s" . nil)))
  (leaf helm-types :bind (:helm-generic-files-map ("C-s" . nil)))
  (leaf helm-ls-git
    :ensure t
    :require t
    :defvar helm-source-ls-git-status helm-source-ls-git helm-source-ls-git-buffers
    :defun helm-ls-git-build-git-status-source helm-ls-git-build-ls-git-source helm-ls-git-build-buffers-source
    :config
    (setq helm-source-ls-git-status
          (helm-ls-git-build-git-status-source)
          helm-source-ls-git
          (helm-ls-git-build-ls-git-source)
          helm-source-ls-git-buffers
          (helm-ls-git-build-buffers-source)))
  (leaf helm-descbinds :ensure t :config (helm-descbinds-mode)))

(leaf helm-ag
  :ensure t
  :require t
  :custom ((helm-ag-base-command . "rg --no-heading --smart-case")
           (helm-grep-ag-command . "rg --color=always --smart-case --no-heading --line-number %s %s %s"))
  :commands helm-ag--project-root
  :config
  (advice-add 'helm-ag--save-current-context :after 'xref-push-marker-stack)

  (defun helm-do-ag-project-root-or-default ()
    (interactive)
    (if (helm-ag--project-root)
        (helm-do-ag-project-root)
      (helm-do-ag)))

  (defun helm-do-ag-project-root-or-default-at-point ()
    (interactive)
    (defvar helm-ag-insert-at-point)
    (let ((helm-ag-insert-at-point 'symbol))
      (helm-do-ag-project-root-or-default)))

  (defun helm-do-ag-current-dir ()
    (interactive)
    (helm-do-ag default-directory)))

(leaf rg
  :ensure t
  :after t
  :defvar rg-mode-map
  :config (ncaq-set-key rg-mode-map))

(leaf ggtags
  :ensure t
  :preface
  (eval-and-compile
    (defun gtags-dir? ()
      (locate-dominating-file default-directory "GTAGS")))

  (defun ggtags-mode-when-gtags-dir ()
    (when (gtags-dir?)
      (ggtags-mode 1)))

  (add-hook 'find-file-hook 'ggtags-mode-when-gtags-dir)
  :custom ((ggtags-enable-navigation-keys . nil)
           (ggtags-global-ignore-case . t)))

(leaf smart-jump
  :ensure t
  :config (smart-jump-setup-default-registers)
  (leaf ag :ensure t))

(leaf magit
  :ensure t
  :config
  (leaf gitignore-mode :ensure t)
  (leaf magit-files
    :bind (:magit-file-mode-map ("C-x g" . nil)))
  (leaf magit-mode
    :after t
    :defvar magit-mode-map
    :config (swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-commit
    :after t
    :defvar git-commit-mode-map
    :config (swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-rebase
    :after t
    :defvar git-rebase-mode-map
    :config (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t")))))

(leaf git-gutter
  :ensure t
  :custom (global-git-gutter-mode . t))

(leaf mozc-im
  :ensure t
  :require t
  :custom ((default-input-method . "japanese-mozc-im") (mozc-candidate-style . 'echo-area))
  :config
  (defun cursor-color-toggle ()
    (if current-input-method
        (set-face-background 'cursor "#00629D")
      (set-face-background 'cursor "#839496")))

  (defun cursor-color-direct ()
    (set-face-background 'cursor "#839496"))

  (set-face-background 'mozc-preedit-selected-face "#268bd2")
  (add-hook 'input-method-activate-hook 'cursor-color-toggle)
  (add-hook 'input-method-deactivate-hook 'cursor-color-direct)
  (add-hook 'window-configuration-change-hook 'cursor-color-toggle))

(leaf docker
  :ensure t
  :custom (docker-container-shell-file-name . "/bin/bash"))

(leaf smartparens
  :ensure t
  :require smartparens-config
  :defun sp-pair
  :custom (sp-escape-quotes-after-insert . nil)
  :bind (:smartparens-mode-map
         ("C-(" . sp-backward-slurp-sexp)
         ("C-)" . sp-slurp-hybrid-sexp)
         ("M-(" . sp-backward-barf-sexp)
         ("M-)" . sp-forward-barf-sexp)
         ("M-k" . sp-splice-sexp)
         ("C-M-k" . sp-raise-sexp)
         ("C-M-u" . sp-split-sexp)
         ([remap backward-kill-sexp] . sp-backward-kill-sexp)
         ([remap backward-list] . sp-backward-symbol)
         ([remap backward-sexp] . sp-backward-sexp)
         ([remap beginning-of-defun] . sp-backward-down-sexp)
         ([remap end-of-defun] . sp-down-sexp)
         ([remap forward-list] . sp-forward-symbol)
         ([remap forward-sexp] . sp-forward-sexp)
         ([remap kill-sexp] . sp-kill-sexp)
         )
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)

  ;; based on https://github.com/Fuco1/smartparens/wiki/Permissions
  (defun my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))

(leaf string-inflection
  :ensure t
  :config
  (defun my-string-inflection-cycle-auto ()
    "switching by major-mode"
    (interactive)
    (cond
     ;; for emacs-lisp-mode
     ((eq major-mode 'emacs-lisp-mode)
      (string-inflection-all-cycle))
     ;; for python
     ((eq major-mode 'python-mode)
      (string-inflection-python-style-cycle))
     ;; for java
     ((eq major-mode 'java-mode)
      (string-inflection-java-style-cycle))
     (t
      ;; default
      (string-inflection-ruby-style-cycle)))))

(leaf undo-tree
  :ensure t
  :require t
  :defvar undo-tree-visualizer-mode-map
  :custom ((undo-tree-enable-undo-in-region . nil)
           (undo-tree-history-directory-alist . `(("" . ,(concat user-emacs-directory "undo-tree/"))))
           (undo-tree-visualizer-timestamps . t))
  :config
  (global-undo-tree-mode)
  (ncaq-set-key undo-tree-visualizer-mode-map)
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit))

(leaf whitespace
  :require t
  :custom ((global-whitespace-mode . 1)
           (whitespace-action . '(auto-cleanup))
           (whitespace-style . '(face tabs spaces trailing empty)))
  :defvar whitespace-action
  :config
  (defun whitespace-cleanup-turn-off ()
    (interactive)
    (setq-local whitespace-action (remove 'auto-cleanup whitespace-action)))
  (set-face-background 'whitespace-space "#073642")
  (set-face-foreground 'whitespace-empty "#5a2c2b")
  (set-face-foreground 'whitespace-tab "#0C2B33")
  (set-face-foreground 'whitespace-trailing "#332B28"))

(leaf auto-sudoedit :ensure t :config (auto-sudoedit-mode 1))
(leaf editorconfig :ensure t :config (editorconfig-mode 1))
(leaf multiple-cursors :ensure t)
(leaf ncaq-emacs-utils :require t)
(leaf symbolword-mode :ensure t :require t)
(leaf which-key :ensure t :config (which-key-mode 1))
(leaf yasnippet :ensure t :require t :config (yas-global-mode))

(leaf flycheck
  :ensure t
  :require t
  :custom ((global-flycheck-mode . t)
           (flycheck-display-errors-function . nil) ; Echoエリアにエラーを表示しない
           (flycheck-highlighting-mode . nil)       ; 下線があると_が見えなくなる
           (flycheck-indication-mode 'left-fringe))
  :bind (:flycheck-mode-map
         ([remap previous-error] . flycheck-previous-error)
         ([remap next-error] . flycheck-next-error)))

(leaf lsp-mode
  :ensure t
  :require t
  :defvar company-backends
  :custom (lsp-prefer-flymake . nil)    ; flycheckを優先する
  :hook
  (css-mode-hook
   go-mode-hook
   haskell-mode-hook
   java-mode-hook
   python-mode-hook
   ruby-mode-hook
   scala-mode-hook
   typescript-mode-hook
   . lsp)
  :bind (:lsp-mode-map
         ("C-c C-e" . lsp-workspace-restart)
         ("C-c C-i" . lsp-format-buffer)
         ("C-c C-n" . lsp-rename)
         ("C-c C-r" . lsp-execute-code-action)
         ("C-c C-t" . lsp-describe-thing-at-point))
  :config
  (leaf helm-lsp
    :ensure t
    :bind (:lsp-mode-map :package lsp-mode ("C-." . helm-lsp-workspace-symbol)))
  (leaf company-lsp
    :ensure t
    :require t
    :config
    (push 'company-lsp company-backends)))

(leaf lsp-ui
  :ensure t
  :defun lsp--text-document-position-params lsp-request lsp-ui-doc--display lsp-ui-doc--extract
  :custom (lsp-ui-doc-delay . 2)         ; 初期値の0.2はせわしなさすぎる
  :bind (:lsp-mode-map ("C-c C-d" . lsp-ui-doc-show)))

(leaf quickrun
  :ensure t
  :after t
  :config
  (quickrun-add-command "haskell"
    '((:command . "stack runghc")
      (:description . "Run Haskell file with Stack runghc(GHC)"))
    :override t))

(leaf generic-x :require t)

(leaf conf-mode
  :config
  (leaf conf-space-mode
    :mode
    "\\.accept_keywords$"
    "\\.keywords$"
    "\\.license$"
    "\\.mask$"
    "\\.unmask$"
    "\\.use$"
    ))

(leaf csharp-mode :ensure t)
(leaf dockerfile-mode :ensure t)
(leaf go-mode :ensure t)
(leaf graphviz-dot-mode :ensure t :custom (graphviz-dot-auto-indent-on-semi . nil)) ; dotファイルで自動セミコロン挿入しない
(leaf make-mode :after t :defvar makefile-mode-map :config (ncaq-set-key makefile-mode-map))
(leaf mediawiki :ensure t :mode "\\.wiki$")
(leaf pascal :after t :defvar pascal-mode-map :config (ncaq-set-key pascal-mode-map))
(leaf prolog :after t :defvar prolog-mode-map :config (ncaq-set-key prolog-mode-map))
(leaf sh-script :config (leaf shell-script-mode :mode "\\.zsh$"))
(leaf ssh-config-mode :ensure t :mode "\\.ssh/config$" "sshd?_config$")
(leaf systemd :ensure t)

(leaf cc-mode
  :after t
  :defvar c-mode-base-map c-mode-map c++-mode-map
  :config
  (leaf clang-format
    :ensure t
    :config
    (defun set-hook-after-save-clang-format ()
      (add-hook 'after-save-hook 'clang-format-buffer t t)))
  (add-hook 'c-mode-hook 'set-hook-after-save-clang-format)
  (add-hook 'c++-mode-hook 'set-hook-after-save-clang-format)

  (ncaq-set-key c-mode-base-map)
  (define-key c-mode-map [remap indent-whole-buffer] 'clang-format-buffer)
  (define-key c++-mode-map [remap indent-whole-buffer] 'clang-format-buffer))

(leaf d-mode
  :ensure t
  :after cc-vars
  :custom ((c-default-style . (cons '(d-mode . "java") c-default-style))
           (dfmt-flags . '("--max_line_length=80")))
  :bind (:d-mode-map
         ([remap indent-whole-buffer] . dfmt-region-or-buffer)
         ([remap save-buffer] . 'save-buffer-and-dfmt))
  :defun dfmt-buffer
  :config
  (defun save-buffer-and-dfmt ()
    "セーブした後dfmt-bufferする.
dfmt-bufferを先にしたりbefore-save-hookを使ったりすると
保存がキャンセルされてflycheckの恩恵を受けられない
"
    (interactive)
    (when (buffer-modified-p)
      (save-buffer)
      (when (and (dfmt-buffer) (buffer-modified-p)) (save-buffer)))))

(leaf elisp-mode
  :bind (:emacs-lisp-mode-map ("C-M-q" . nil))
  :custom ((flycheck-emacs-lisp-load-path . 'inherit))
  :config
  (leaf flycheck-package :ensure t :after flycheck :defun flycheck-package-setup :config (flycheck-package-setup))
  (leaf eldoc :hook emacs-lisp-mode-hook ielm-mode-hook)
  (leaf elisp-slime-nav
    :ensure t
    :hook emacs-lisp-mode-hook help-mode-hook
    :bind (:elisp-slime-nav-mode-map ("C-c C-d" . elisp-slime-nav-describe-elisp-thing-at-point)))
  (leaf simple
    :bind (:read-expression-map ("<tab>" . completion-at-point))))

(leaf haskell-mode
  :ensure t
  :after t
  :defvar flycheck-error-list-buffer flymake-allowed-file-name-masks
  :bind (:haskell-mode-map
         (("C-M-z" . haskell-repl-and-flycheck)
          ("C-c C-c" . haskell-session-change-target)
          ("C-c C-l" . haskell-process-load-file)
          ("C-c C-z" . haskell-interactive-switch)
          ([remap indent-whole-buffer] . haskell-mode-stylish-buffer)))
  :config
  (leaf lsp-haskell
    :ensure t
    :require t
    :custom (flymake-proc-allowed-file-name-masks . (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks)))
  (leaf haskell-customize
    :custom (haskell-stylish-on-save . t)
    :config
    (defun stylish-haskell-enable ()
      (interactive)
      (custom-set-variables '(haskell-stylish-on-save t)))
    (defun stylish-haskell-disable ()
      (interactive)
      (custom-set-variables '(haskell-stylish-on-save nil))))
  (leaf haskell-interactive-mode
    :after t
    :defvar haskell-interactive-mode-map
    :config (ncaq-set-key haskell-interactive-mode-map))
  (leaf haskell-cabal
    :after t
    :defvar haskell-cabal-mode-map
    :config (ncaq-set-key haskell-cabal-mode-map))
  (defun haskell-repl-and-flycheck ()
    (interactive)
    (delete-other-windows)
    (flycheck-list-errors)
    (haskell-process-load-file)
    (haskell-interactive-switch)
    (split-window-below)
    (other-window 1)
    (switch-to-buffer flycheck-error-list-buffer)
    (other-window 1)))

(leaf hamlet-mode
  :ensure t
  :config
  (defun hamlet-mode-config ()
    (local-set-key (kbd "C-m") 'newline-and-indent)
    (electric-indent-local-mode -1))
  (add-hook 'hamlet-mode-hook 'hamlet-mode-config))

(leaf lsp-java
  :ensure t
  :require t
  :after cc-mode)

(leaf markdown-mode
  :ensure t
  :after t
  :custom ((markdown-fontify-code-blocks-natively . t)
           (markdown-hide-urls . nil))
  :defvar markdown-mode-map
  :config
  (custom-set-variables
   '(markdown-code-lang-modes
     (append
      '(("diff" . diff-mode)
        ("hs" . haskell-mode)
        ("html" . web-mode)
        ("ini" . conf-mode)
        ("js" . web-mode)
        ("jsx" . web-mode)
        ("md" . markdown-mode)
        ("pl6" . perl6-mode)
        ("py" . python-mode)
        ("rb" . ruby-mode)
        ("rs" . rustic-mode)
        ("sqlite3" . sql-mode)
        ("ts" . typescript-mode)
        ("tsx" . web-mode)
        ("yaml". yaml-mode)
        ("zsh" . sh-mode))
      markdown-code-lang-modes)))
  (ncaq-set-key markdown-mode-map))

(leaf perl6-mode
  :ensure t
  :custom (perl6-indent-offset . 2)
  :config (leaf flycheck-perl6 :ensure t))

(leaf ruby-mode
  :custom ((inf-ruby-default-implementation . "pry")
           (inf-ruby-eval-binding . "Pry.toplevel_binding")
           (ruby-insert-encoding-magic-comment . nil))
  :after t
  :defvar ruby-mode-map
  :config (ncaq-set-key ruby-mode-map))

(leaf rustic
  :ensure t
  :mode "\\.rs$"
  :custom ((rustic-format-display-method . 'pop-to-buffer-without-switch) ; エラーポップアップにフォーカスを移さない
           (rustic-format-on-save . t))                                   ; 保存時にrustfmtを動かす
  :after flycheck
  :defun flycheck-select-checker
  :config
  (defun pop-to-buffer-without-switch (buffer-or-name &optional action norecord)
    "本当にwithout switchしているわけではなく前のウィンドウにフォーカスを戻すだけ"
    (pop-to-buffer buffer-or-name action norecord)
    (other-window -1))

  (defun flycheck-select-checker-rustic ()
    "rusticの場合のみclippyが見えるようになるのでlspではなくrustic特有のflycheckを使う"
    (flycheck-select-checker 'rustic-clippy))
  (add-hook 'rustic-mode-hook 'flycheck-select-checker-rustic))

(leaf scala-mode
  :ensure t
  :config
  (defun lsp-format-buffer-after-save ()
    (add-hook 'after-save-hook 'lsp-format-buffer nil t))
  (add-hook 'scala-mode-hook 'lsp-format-buffer-after-save))

(leaf sbt-mode :ensure t :bind (:sbt:mode-map ("M-t" . comint-previous-input)))

(leaf *web
  :config
  (leaf prettier-js
    :ensure t
    :hook
    css-mode-hook
    json-mode-hook
    less-css-mode-hook
    scss-mode-hook
    typescript-mode-hook
    yaml-mode-hook
    :config
    (eval-and-compile
      (defun prettier-js-mode-enable ()
        (interactive)
        (prettier-js-mode t))))

  (eval-and-compile
    (defun flycheck-select-tslint-or-eslint ()
      "tslintが使えるプロジェクトだとtslintを有効化して,それ以外ではeslintを有効化する"
      (if (and
           ;; 大前提としてtslint.jsonがないとだめ
           (locate-dominating-file default-directory "tslint.json")
           (or
            ;; メジャーモードがTypeScriptなら良い
            (equal major-mode 'typescript-mode)
            ;; それ以外のメジャーモード(web-modeとか)でも拡張子がts, tsxなら良い
            (member (file-name-extension (buffer-file-name)) '("ts" "tsx"))))
          (flycheck-select-checker 'typescript-tslint)
        (when (executable-find "eslint")
          (progn
            (flycheck-select-checker 'javascript-eslint)
            (add-hook 'after-save-hook 'eslint-fix nil t))))))

  (leaf web-mode
    :ensure t
    :require t
    :defvar web-mode-content-type
    :defun flycheck-add-mode sp-local-pair
    :mode
    "\\.[agj]sp\\'"
    "\\.as[cp]x\\'"
    "\\.css\\'"
    "\\.djhtml\\'"
    "\\.ejs\\'"
    "\\.erb\\'"
    "\\.html?\\'"
    "\\.js\\'"
    "\\.jsx\\'"
    "\\.mustache\\'"
    "\\.php\\'"
    "\\.phtml\\'"
    "\\.tpl\\'"
    "\\.tsx\\'"
    :custom ((web-mode-code-indent-offset . 2)
             (web-mode-css-indent-offset . 2)
             (web-mode-enable-auto-indentation . nil)
             (web-mode-enable-auto-quoting . nil)
             (web-mode-enable-current-column-highlight . t)
             (web-mode-enable-current-element-highlight . t)
             (web-mode-markup-indent-offset . 2))
    :config
    (sp-local-pair '(web-mode) "<" ">" :actions :rem)
    (set-face-background 'web-mode-jsx-depth-1-face "#073844")
    (set-face-background 'web-mode-jsx-depth-2-face "#083C49")
    (set-face-background 'web-mode-jsx-depth-3-face "#08404F")
    (set-face-background 'web-mode-jsx-depth-4-face "#094554")
    (set-face-background 'web-mode-jsx-depth-5-face "#0A4D5E")

    (flycheck-add-mode 'html-tidy 'web-mode)
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (flycheck-add-mode 'typescript-tslint 'web-mode)
    (defun web-mode-setting ()
      (cond
       ((string= web-mode-content-type "html")
        (progn
          (prettier-js-mode-enable)
          (when (executable-find "tidy") (flycheck-select-checker 'html-tidy))))
       ((member web-mode-content-type '("javascript" "jsx"))
        (progn
          (lsp)
          (flycheck-select-tslint-or-eslint))))
      (when (member web-mode-content-type '("css" "javascript" "json" "jsx"))
        (prettier-js-mode-enable)))
    (add-hook 'web-mode-hook 'web-mode-setting))

  (leaf js :custom (js-indent-level . 2))
  (leaf typescript-mode
    :ensure t
    :custom (typescript-indent-level . 2)
    :config
    (flycheck-add-mode 'javascript-eslint 'typescript-mode)
    (add-hook 'typescript-mode-hook 'flycheck-select-tslint-or-eslint))
  (leaf yaml-mode :ensure t)

  (leaf eslint-fix
    :ensure t
    :config (advice-add 'eslint-fix :after 'flycheck-buffer))) ; fixされたらエラーバッファを更新する

(leaf nxml-mode
  :mode "\\.fxml\\'"
  :custom (nxml-slash-auto-complete-flag . t)
  :after t
  :defvar nxml-mode-map
  :bind (:nxml-mode-map
         ("M-b" . nil)
         ("C-M-p" . nil)
         ("C-M-t" . nxml-backward-element))
  :config
  (leaf smartparens :config (sp-local-pair '(nxml-mode) "<" ">" :actions :rem))
  (ncaq-set-key nxml-mode-map))

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
