;; -*- lexical-binding: t -*-

;; GCの設定
;; 起動にも影響するのでleaf無しで最初にやります
(setq gc-cons-threshold 200000000)            ; 200MB
(run-with-idle-timer 120 t #'garbage-collect) ; 2分のアイドル時間ごとに明示的にガベージコレクトを呼び出す

;;; 初期化

;; (require 'cl) を見逃す
(setq byte-compile-warnings '(not cl-functions obsolete))

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
      :config
      (leaf diminish :ensure t)
      (leaf el-get :ensure t :custom ((el-get-git-shallow-clone . t)))
      (leaf-keywords-init))))

(leaf cus-edit :custom `((custom-file . ,(locate-user-emacs-file "custom.el")))) ; init.elに自動的に書き込ませない

(leaf leaf-convert :ensure t)
(leaf leaf-tree :ensure t)

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  "バッファが存在すればkillする. 無ければ何もしない."
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

;; 起動時に作られる使わないバッファを削除する
(kill-buffer-if-exist "*scratch*")

(leaf server
  :require t
  :defun server-running-p
  :config (unless (server-running-p) (server-start)))

;;; ある程度独立した定義。

(leaf f
  :ensure t
  :require t
  :defun f-file? f-read-text
  :config
  (defvar system-type-wsl
    (let ((osrelease-file "/proc/sys/kernel/osrelease"))
      (and
       (eq system-type 'gnu/linux)
       (f-file? osrelease-file)
       (string-match-p "WSL" (f-read-text osrelease-file))))
    "EmacsがWSLで動いているか?"))

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

;;; Dvorak設定をするための関数達

(defun reverse-cons (c)
  "consセル、つまりpairをswap。"
  (cons (cdr c) (car c)))

(defun trans-bind (key-map key-pair)
  "(入れ替え先のキー, 再設定するコマンド)を生成。"
  (cons (kbd (car key-pair)) (command-or-nil (lookup-key key-map (kbd (cdr key-pair))))))

(defun command-or-nil (symbol)
  "対象がコマンドでない場合はnilを返す。"
  (when (commandp symbol) symbol))

(defun swap-set-key (key-map key-pairs)
  "key-pairsのデータに従ってキーを入れ替える。"
  (mapc
   (lambda (kc)
     (when (or (cdr kc) (lookup-key key-map (car kc)))
       ;; 無駄にnilを増やさないように新規コマンドがnilで挿入先キーマップのコマンドもnilならキーを挿入しない。
       (define-key key-map (car kc) (cdr kc))))
   (mapcar
    (lambda (kp)
      (trans-bind key-map kp))
    (append key-pairs (mapcar 'reverse-cons key-pairs)))))

(defconst qwerty-dvorak
  '(("b" . "h")
    ("f" . "s")
    ("p" . "t"))
  "htnsbf形式のために標準的に入れ替える必要があるキー。")

(defun prefix-key-pair (from-prefix to-prefix key-pair)
  "プレフィクス付きの入れ替えキーペアを作る。"
  (cons (concat from-prefix (car key-pair)) (concat to-prefix (cdr key-pair))))

(defun dvorak-set-key (key-map)
  "標準的なモードをhtnsbf形式にする。"
  (let ((prefixes '((""       . "")
                    ("C-"     . "C-")
                    ("M-"     . "M-")
                    ("C-M-"   . "C-M-")
                    ("C-c C-" . "C-c C-")
                    ("M-g M-" . "M-g M-"))))
    (mapc
     (lambda (pp)
       (swap-set-key key-map (mapcar
                              (lambda (kp)
                                (prefix-key-pair (car pp) (cdr pp) kp))
                              qwerty-dvorak)))
     prefixes)))

(defun dvorak-set-key-prog (key-map)
  "prog-modeベースのマップに対して入れ替えを設定する。"
  (swap-set-key key-map '(("M-h" . "C-x p") ("C-M-h" . "C-x d")))
  (mapc
   (lambda (key)
     (when (lookup-key key-map key)
       (define-key key-map (kbd key) 'nil)))
   '("C-o" "M-b" "C-M-b" "C-q" "M-q" "C-M-q"))
  (dvorak-set-key key-map))

;;; Dvorak設定をするだけのコード

(dvorak-set-key global-map)
(swap-set-key global-map '(("M-g p" . "M-g t")))

;; minibuffer-local-map is a variable defined in `C source code'.
(dvorak-set-key-prog minibuffer-local-map)

(leaf isearch
  :bind (:isearch-mode-map
         ("C-b" . isearch-delete-char)
         ("M-b" . isearc-del-char)
         ("M-m" . isearch-exit-previous))
  :config (dvorak-set-key-prog isearch-mode-map))

(leaf popup
  :ensure t
  ;; 何故か`popup-close'などは`interactive'ではないため自前で書いて強制的に書き換える
  ;; 何故`interactive'じゃないのに動くんでしょう…
  :bind (:popup-menu-keymap
         ("C-f" . popup-isearch)
         ("C-b" . nil)
         ("C-p" . nil)
         ("C-t" . popup-previous)
         ("C-s" . popup-open)))

(leaf compile
  :after t
  :defvar compilation-minor-mode-map compilation-mode-map compilation-shell-minor-mode-map
  :config
  (dvorak-set-key-prog compilation-minor-mode-map)
  (dvorak-set-key-prog compilation-mode-map)
  (dvorak-set-key-prog compilation-shell-minor-mode-map))

(leaf hexl
  :bind (:hexl-mode-map
         ("C-t" . nil)                  ; undefinedを無効化する
         ("M-g" . nil)
         ([remap quoted-insert] . hexl-quoted-insert))
  :config (dvorak-set-key-prog hexl-mode-map))

(leaf info      :after t :config (dvorak-set-key-prog Info-mode-map))
(leaf prog-mode :after t :config (dvorak-set-key-prog prog-mode-map))

(leaf comint    :after t :defvar comint-mode-map         :config (dvorak-set-key-prog comint-mode-map))
(leaf diff-mode :after t :defvar diff-mode-map           :config (dvorak-set-key-prog diff-mode-map))
(leaf doc-view  :after t :defvar doc-view-mode-map       :config (dvorak-set-key-prog doc-view-mode-map))
(leaf help-mode :after t :defvar help-mode-map           :config (dvorak-set-key-prog help-mode-map))
(leaf rect      :after t :defvar rectangle-mark-mode-map :config (dvorak-set-key-prog rectangle-mark-mode-map))
(leaf rst       :after t :defvar rst-mode-map            :config (dvorak-set-key-prog rst-mode-map))

(leaf flyspell :after t :bind (:flyspell-mode-map ("C-," . nil) ("C-." . nil)))

;;; global-set-key

(leaf *global-set-key
  :leaf-autoload nil
  :bind
  ("<tab>" . indent-for-tab-command) ; 何かしらを割り当てることで, C-iと別扱いになる

  ("C-'" . mc/mark-all-dwim)
  ("C-+" . text-scale-increase)
  ("C-," . off-input-method)
  ("C--" . text-scale-decrease)
  ("C-." . on-input-method)
  ("C-;" . my-string-inflection-cycle-auto)
  ("C-=" . text-scale-reset)
  ("C-^" . dired-jump-to-current)
  ("C-a" . smart-move-beginning-of-line)
  ("C-b" . backward-delete-char-untabify)
  ("C-i" . indent-whole-buffer)
  ("C-j" . helm-do-grep-ag-project-dir-or-fallback)
  ("C-o" . helm-for-files-prefer-recentf)
  ("C-p" . other-window-fallback-split)
  ("C-q" . kill-this-buffer)
  ("C-u" . kill-whole-line)
  ("C-w" . kill-region-or-symbol-at-point)
  ("C-z" . nil)

  ("C-\\" . quoted-insert)

  ("C-S-b" . delete-whitespace-backward)
  ("C-S-d" . delete-whitespace-forward)
  ("C-S-m" . quoted-newline)

  ("M-/" . point-undo)
  ("M-?" . point-redo)
  ("M-b" . backward-kill-word)
  ("M-c" . help-command)
  ("M-f" . helm-swoop)
  ("M-j" . helm-do-grep-ag)
  ("M-l" . sort-dwim)
  ("M-m" . newline-under)
  ("M-n" . scroll-up-one)
  ("M-o" . helm-for-files-prefer-near)
  ("M-p" . other-window-backward)
  ("M-q" . delete-other-windows)
  ("M-r" . revert-buffer-safe-confirm)
  ("M-t" . scroll-down-one)
  ("M-u" . copy-whole-line)
  ("M-w" . kill-ring-save-region-or-symbol-at-point)
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("M-z" . lsp)

  ("C-M-'" . mc/edit-lines)
  ("C-M-," . helm-semantic-or-imenu)
  ("C-M-b" . backward-kill-sexp)
  ("C-M-d" . kill-sexp)
  ("C-M-l" . delete-duplicate-lines)
  ("C-M-m" . comment-indent-new-line)
  ("C-M-o" . ibuffer)
  ("C-M-p" . split-window-dwim-and-other)
  ("C-M-q" . kill-buffer-and-window)
  ("C-M-w" . copy-to-register-@)
  ("C-M-y" . yank-register-@)

  ("C-M-S-q" . kill-file-or-dired-buffers)

  ("C-c '" . google-this)
  ("C-c ;" . align-regexp)
  ("C-c a" . open-downloads)
  ("C-c c" . quickrun)
  ("C-c d" . docker)
  ("C-c e" . open-ncaq-entry)
  ("C-c j" . rg)
  ("C-c o" . open-desktop)
  ("C-c p" . package-list-packages)
  ("C-c r" . recentf-cleanup)
  ("C-c s" . customize-set-variable)
  ("C-c u" . open-document-current)

  ("C-x d" . mark-defun)
  ("C-x g" . insert-random-uuid)
  ("C-x p" . mark-paragraph)
  ("C-x t" . insert-iso-datetime)
  ("C-x w" . mark-whole-word)
  ("C-x x" . mark-whole-sexp)

  ("C-c C-;" . align-space)

  ("C-x C-f" . helm-find-files)

  ("M-g a" . magit-snapshot-both)
  ("M-g b" . magit-blame)
  ("M-g c" . magit-commit)
  ("M-g d" . magit-diff)
  ("M-g f" . magit-find-file)
  ("M-g g" . magit-dispatch)
  ("M-g l" . magit-log-buffer-file)
  ("M-g p" . magit-push)
  ("M-g r" . magit-reset)
  ("M-g s" . magit-status)
  ("M-g u" . magit-pull)
  ("M-g w" . magit-branch-checkout)
  ("M-g z" . magit-stash-both)

  ("<help> c" . helpful-command)
  ("<help> w" . helm-man-woman)

  ("C-x <RET> u" . revert-buffer-with-coding-system-utf-8-unix)
  ("C-x <RET> s" . revert-buffer-with-coding-system-japanese-cp932-dos))

;;; 見た目

(leaf *font
  :config
  (set-face-attribute 'default nil :family "HackGenNerd Console" :height 135)
  (set-fontset-font t 'unicode (font-spec :name "HackGenNerd Console") nil 'append)
  (set-fontset-font t '(#x1F000 . #x1FAFF) (font-spec :name "Noto Color Emoji") nil 'append))

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
  :custom-face (rainbow-delimiters-depth-1-face . '((t (:foreground "#586e75"))))) ; 文字列の色と被るため変更

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
  web-mode-hook)

;; カットペーストなど挿入削除時にハイライト
(leaf volatile-highlights :ensure t :config (volatile-highlights-mode t))

;; 置換の動きを可視化
(leaf anzu
  :ensure t
  :custom (global-anzu-mode . t)
  :bind
  ([remap query-replace] . anzu-query-replace)
  ([remap query-replace-regexp] . anzu-query-replace-regexp))

;;; History

(leaf recentf
  :custom
  ((recentf-max-saved-items . 2000)
   (recentf-exclude . '("\\.elc$" "\\.o$" "~$" "\\.file-backup/" "\\.undo-tree/" "EDITMSG" "PATH" "TAGS" "autoloads"))))

(leaf recentf-ext :ensure t :require t)
(leaf recentf-remove-sudo-tramp-prefix :ensure t :config (recentf-remove-sudo-tramp-prefix-mode 1))

(leaf savehist :custom (savehist-mode . t))

(leaf desktop
  :custom
  (desktop-save-mode . t)
  (desktop-globals-to-save . nil)
  (desktop-restore-frames . nil))

(leaf save-place-mode :config (save-place-mode 1))

(leaf files
  :custom
  ;; バックアップ先をカレントディレクトリから変更
  (backup-directory-alist . `(("" . ,(concat user-emacs-directory "file-backup/"))))
  ;; 自動保存(クラッシュ時の対応)先をカレントディレクトリから変更
  (auto-save-file-name-transforms . `((".*" ,temporary-file-directory t)))
  ;; askだと件数を超えた自動削除時時に一々聞いてくるのでtに変更
  (delete-old-versions . t)
  ;; backupに新しいものをいくつ残すか
  (kept-new-versions . 10)
  ;; backupに古いものをいくつ残すか
  (kept-old-versions . 0)
  ;; バックアップファイル %backup%~ を作成しない。
  ;; BtrfsとSnapperの環境下で作業することが多くなったのでEmacs側で単一のバックアップファイルを生成するメリットがあまりない。
  ;; その割に終了時やパッケージ読み込み時のcustom.el(いらない)のバックアップを一々取るパフォーマンス上のデメリットが多い。
  (make-backup-files . nil)
  ;; 複数バックアップ
  (version-control . t))

(leaf tramp :custom (tramp-auto-save-directory . temporary-file-directory)) ; trampの自動保存ディレクトリをtmpにする
(leaf filelock :custom (create-lockfiles . nil)) ; percelがバグるのでロックファイルとしてシンボリックリンクを作らない

;;; toolkit

(leaf menu-bar :custom (menu-bar-mode . nil))        ; メニューバーを表示させない
(leaf tool-bar :custom (tool-bar-mode . nil))        ; ツールバーを表示させない
(leaf image-file :custom (auto-image-file-mode . 1)) ; 画像を表示

(leaf bindings
  :config
  ;; ((ファイル名 or バッファ名) モード一覧)
  (setq frame-title-format '(:eval (list "emacs " (or (buffer-file-name) (buffer-name)) " " mode-line-modes)))
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
           "/%i"))))

;; バッファの名前にディレクトリ名を付けることでユニークになりやすくする
(leaf uniquify :require t :custom (uniquify-buffer-name-style . 'forward))

(leaf mule-util
  :doc
  "省略記号に使う文字列幅を3文字から1文字にします。"
  :require t
  :defvar truncate-string-ellipsis
  :setq (truncate-string-ellipsis . "…"))

;;; その他

(leaf package
  :init
  (defun package-menu-mode-setup ()
    "パッケージ名の幅を広く取ります。"
    (setf (cadr (aref tabulated-list-format 0)) 50))
  :hook (package-menu-mode-hook . package-menu-mode-setup))

(leaf dired
  :init
  (defun dired-jump-to-current ()
    "バッファが属しているディレクトリを開きます。"
    (interactive)
    (dired "."))
  :custom
  (dired-auto-revert-buffer . t)        ; diredの自動再読込
  (dired-dwim-target . t)               ; コピーなどを行う時に隣のバッファを対象にする
  (dired-isearch-filenames . t)         ; isearchの対象をファイル名のみにする
  (dired-recursive-copies . 'always)    ; 聞かずに再帰的コピー
  (dired-recursive-deletes . 'always)   ; 聞かずに再帰的削除
  `(dired-listing-switches
    . ,(concat "-Fhval" (when (string-prefix-p "gnu" (symbol-name system-type)) " --group-directories-first")))
  :bind (:dired-mode-map
         ("C-o" . nil)
         ("C-p" . nil)
         ("M-o" . nil)
         ("C-^" . dired-up-directory)
         ("C-c C-t" . wdired-change-to-wdired-mode))
  :config (dvorak-set-key-prog dired-mode-map))

(leaf *c-source-code
  :custom
  (delete-by-moving-to-trash . t)             ; ごみ箱を有効
  (fill-column . 1000)                        ; auto fillを実質無効化(ちゃんとした無効化方法がわからない)
  (indent-tabs-mode . nil)                    ; インデントをスペースで行う
  (message-log-max . 100000)                  ; メッセージをたくさん残す
  (read-buffer-completion-ignore-case . t)    ; 大文字と小文字を区別しない バッファ名
  (read-file-name-completion-ignore-case . t) ; 大文字と小文字を区別しない ファイル名
  (scroll-conservatively . 1)                 ; 最下段までスクロールした時のカーソルの移動量を減らす
  (scroll-margin . 5)                         ; 最下段までスクロールしたという判定を伸ばす
  :setq-default
  (buffer-file-coding-system . 'utf-8-unix)) ; 新規ファイルではWindowsでもUTF-8を使う

(leaf man
  :after t
  :defvar Man-mode-map
  :custom
  (Man-notify-method . 'bully)          ; Manページを現在のウィンドウで表示
  (Man-width-max . nil)                 ; Manページのwidthの最大幅を除去
  :config (dvorak-set-key-prog Man-mode-map))

(leaf ediff
  :custom
  (ediff-split-window-function . 'split-window-horizontally)  ; ediffでウィンドウを横分割
  (ediff-window-setup-function . 'ediff-setup-windows-plain)) ; ediffにframeを生成させない

(leaf autorevert :custom (global-auto-revert-mode . 1)) ; 自動再読込
(leaf executable :hook (after-save-hook . executable-make-buffer-file-executable-if-script-p)) ; スクリプトに実行権限付加
(leaf files :custom (require-final-newline . t)) ; ファイルの最後に改行
(leaf indent :custom (standard-indent . 2)) ; 標準インデント値を出来るだけ2にする
(leaf inf-lisp :custom (inferior-lisp-program . "sbcl --noinform")) ; Common Lispの処理系を設定
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
  :custom `(ibuffer-formats . '((mark modified read-only " " (name 60 30) " " (size 6 -1) " " (mode 16 16) " " filename)
                                (mark " " (name 60 -1) " " filename))) ; 幅を大きくする
  :bind (:ibuffer-mode-map
         ("C-o" . nil)
         ("C-t" . nil)
         ("M-g" . nil))
  :config (dvorak-set-key-prog ibuffer-mode-map))

(leaf profiler
  :after t
  :defvar profiler-report-mode-map
  :custom (profiler-report-cpu-line-format . '((100 left) (24 right ((19 right) (5 right))))) ; 幅を大きくする
  :config (dvorak-set-key-prog profiler-report-mode-map))

(leaf company
  :ensure t
  :require t
  :diminish "COMPA"
  :defvar company-search-map
  :custom
  ;; companyの自動補完スタートを無効化します。
  ;; 理由はhaskell-mode, company-posframeの組み合わせの時、自動補完が一瞬現れては消える謎の挙動をするためです。
  ;; 原因は不明ですが、もともと自動補完開始をあまり使っていなかったため、手動補完開始のみを使うことにします。
  (company-idle-delay . nil)
  (company-dabbrev-code-other-buffers . 'all)
  (company-dabbrev-downcase . nil)
  (company-dabbrev-other-buffers . 'all)
  :bind
  (:company-mode-map
   ("<C-iso-lefttab>" . company-dabbrev)
   ("C-<tab>" . company-complete))
  (:company-active-map
   ("<backtab>" . company-select-previous)
   ("<tab>" . company-complete-common-or-cycle)
   ("C-h" . nil))
  :config
  (global-company-mode 1)
  (dvorak-set-key-prog company-active-map)
  ;; company-search-mapの入力をそのまま受け付ける特殊性に対応するワークアラウンド。
  (define-key company-search-map (kbd "C-c") nil)
  (dvorak-set-key company-search-map)
  (leaf company-quickhelp
    :ensure t
    :require t
    :custom (company-quickhelp-delay . 0)
    :config (company-quickhelp-mode 1))
  (leaf company-posframe
    :doc "ウィンドウ分割などを行いウインドウをまたがる補完のスタイルが崩壊することを抑止してくれます。"
    :ensure t
    :require t desktop
    :diminish "COMPF"
    :defvar desktop-minor-mode-table
    :config
    (company-posframe-mode 1)
    (push '(company-posframe-mode . nil) desktop-minor-mode-table)))

(leaf yasnippet
  :ensure t
  :bind (:yas-minor-mode-map
         ("<tab>" . nil)
         ("TAB" . nil)
         ("C-c C-y" . company-yasnippet))
  :config
  (yas-global-mode)
  (leaf yasnippet-snippets :ensure t))

(leaf helpful
  :ensure t
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-key]      . helpful-key)
  ([remap describe-symbol]   . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  :defvar helpful-mode-map
  :advice (:after helpful-at-point other-window-backward)
  :config (dvorak-set-key-prog helpful-mode-map))

(leaf helm
  :ensure t
  :require t helm-config
  :custom
  ;; ag用コマンドでripgrepを使うように指定
  (helm-grep-ag-command . "rg --color=always --smart-case --no-heading --line-number --type-not=svg --sort=path %s -- %s %s")
  ;; 検索結果でファイル名だけではなくパスも表示する
  (helm-grep-file-path-style . 'absolute)
  ;; モードを短縮する基準
  (helm-buffer-max-len-mode . 25)
  ;; デフォルトはファイル名を短縮する区切りが20
  (helm-buffer-max-length . 50)
  ;; kill-line sim
  (helm-delete-minibuffer-contents-from-point . t)
  ;; helm-find-filesにrecentfを使用する
  (helm-ff-file-name-history-use-recentf . t)
  ;; ウインドウ全体に表示
  (helm-samewindow . t)
  :defvar helm-for-files-preferred-list
  :defun helm-grep-ag project-root helm-do-grep-ag-project-dir
  :init
  (defun helm-for-files-prefer-recentf ()
    "recentfを優先するhelm-for-filesです。"
    (interactive)
    (let ((helm-for-files-preferred-list
           '(helm-source-buffers-list
             helm-source-recentf
             helm-source-ls-git
             helm-source-locate)))
      (helm-for-files)))
  (defun helm-for-files-prefer-near ()
    "git管理下など近い場所のファイルを優先するhelm-for-filesです。"
    (interactive)
    (let ((helm-for-files-preferred-list
           '(helm-source-buffers-list
             helm-source-ls-git
             helm-source-recentf
             helm-source-locate)))
      (helm-for-files)))
  (defun helm-do-grep-ag-project-dir-or-fallback (arg)
    "helm-do-grep-ag-project-dirか、helm-do-grep-agを行います。"
    (interactive "P")
    (let ((in-project (ignore-errors (project-root (project-current)))))
      (if in-project
          (helm-do-grep-ag-project-dir arg)
        (helm-do-grep-ag arg))))
  (defun helm-do-grep-ag-project-dir (arg)
    "プロジェクトディレクトリ以下のファイルを対象にhelm-do-grep-ag検索を行います。"
    (interactive "P")
    (helm-grep-ag (expand-file-name (project-root (project-current))) arg))
  :bind (:helm-map
         ("C-M-b" . nil)
         ("C-b" . nil)
         ("C-h" . nil)
         ("M-b" . nil)
         ("M-s" . nil)
         ("<tab>" . helm-select-action))
  :config
  (helm-mode 1)
  (custom-set-variables
   '(helm-boring-buffer-regexp-list
     (append '("\\*Flymake" "\\*WoMan-Log" "\\*tramp")
             helm-boring-buffer-regexp-list)))
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
    ;; helm-for-filesで出力するのには手動初期化が必要
    (setq helm-source-ls-git-status
          (helm-ls-git-build-git-status-source)
          helm-source-ls-git
          (helm-ls-git-build-ls-git-source)
          helm-source-ls-git-buffers
          (helm-ls-git-build-buffers-source)))
  (leaf helm-descbinds :ensure t :custom (helm-descbinds-mode . t))
  (leaf helm-swoop :ensure t))

;;; ジャンプ

(leaf rg
  :ensure t
  :after t
  :defvar rg-mode-map
  :config (dvorak-set-key-prog rg-mode-map))

(leaf ggtags
  :ensure t
  :init
  (eval-and-compile
    (defun gtags-dir? ()
      (locate-dominating-file default-directory "GTAGS")))
  (defun ggtags-mode-when-gtags-dir ()
    (when (gtags-dir?)
      (ggtags-mode 1)))
  :hook (find-file-hook . ggtags-mode-when-gtags-dir)
  :custom
  (ggtags-enable-navigation-keys . nil)
  (ggtags-global-ignore-case . t))

(leaf smart-jump
  :ensure t
  :defun smart-jump-find-references-with-rg
  :custom
  (smart-jump-find-references-fallback-function . #'smart-jump-find-references-with-rg)
  (smart-jump-refs-key . "C-M-.")
  :bind
  ("M-." . smart-jump-go)
  ("M-," . smart-jump-back)
  ("C-M-." . smart-jump-references))

;;; テキスト処理

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
         ([remap mark-sexp] . sp-mark-sexp))
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)

  (sp-pair "｢" "｣" :actions '(insert wrap autoskip navigate))
  (sp-pair "「" "」" :actions '(insert wrap autoskip navigate))
  (sp-pair "『" "』" :actions '(insert wrap autoskip navigate))

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
    "メジャーモードに従って挙動を変える.
lisp, shell, rakuはハイフンを含めることが出来るのでall.
python, ruby, rustはスネークケースを含むのでruby(pythonはrubyのalias).
その他はjavaスタイル.
"
    (interactive)
    (pcase major-mode
      ((or
        'common-lisp-mode
        'emacs-lisp-mode
        'raku-mode
        'scheme-mode
        'sh-mode
        'wdired-mode)
       (string-inflection-all-cycle))
      ((or
        'python-mode
        'ruby-mode
        'rustic-mode)
       (string-inflection-ruby-style-cycle))
      (_
       (string-inflection-java-style-cycle)))))

(leaf expand-region
  :ensure t
  :bind ("M-'" . er/expand-region))

(leaf undo-tree
  :ensure t
  :diminish "UNDOT"
  :defvar undo-tree-visualizer-mode-map
  :custom
  (global-undo-tree-mode . t)
  (undo-tree-enable-undo-in-region . nil)
  (undo-tree-history-directory-alist . `(("" . ,(concat user-emacs-directory "undo-tree/"))))
  (undo-tree-visualizer-timestamps . t)
  :config
  (dvorak-set-key-prog undo-tree-visualizer-mode-map)
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit))

(leaf whitespace
  :require t
  :custom
  (global-whitespace-mode . 1)
  (whitespace-action . '(auto-cleanup))
  (whitespace-style . '(face tabs spaces trailing empty))
  :custom-face
  (whitespace-empty . '((t (:foreground "#5a2c2b"))))
  (whitespace-space . '((t (:background "#073642"))))
  (whitespace-tab . '((t (:foreground "#0C2B33"))))
  (whitespace-trailing . '((t (:foreground "#332B28"))))
  :defvar whitespace-action
  :init
  (defun whitespace-cleanup-turn-off ()
    (interactive)
    (setq-local whitespace-action (remove 'auto-cleanup whitespace-action))))

;;; Emacsと外部プロセスの連携

(leaf magit
  :ensure t
  :config
  (leaf magit-mode
    :after t
    :defvar magit-mode-map
    :config (swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-commit
    :after t
    :defvar git-commit-mode-map
    :config
    (modify-coding-system-alist 'file "COMMIT_EDITMSG" 'utf-8-unix)
    (swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-rebase
    :after t
    :defvar git-rebase-mode-map
    :config (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-modes :ensure t :mode ("/.dockerignore\\'" . gitignore-mode))
  (leaf forge :ensure t))

(leaf git-gutter
  :ensure t
  :diminish "GITGU"
  :custom (global-git-gutter-mode . t))

(leaf docker
  :ensure t
  :custom (docker-container-shell-file-name . "/bin/bash")
  :init
  (defun docker-image-mode-setup ()
    "イメージ名の幅を広く取ります。"
    (setf (cadr (aref tabulated-list-format 0)) 100))
  :hook
  (docker-image-mode-hook . docker-image-mode-setup))

(leaf *input-method
  :init
  (defun off-input-method ()
    (interactive)
    (deactivate-input-method))
  (defun on-input-method ()
    (interactive)
    (activate-input-method default-input-method))
  (defun cursor-color-toggle ()
    (if current-input-method
        (set-face-background 'cursor "#00629D")
      (set-face-background 'cursor "#839496")))
  (defun cursor-color-direct ()
    (set-face-background 'cursor "#839496"))
  :hook
  (input-method-activate-hook . cursor-color-toggle)
  (input-method-deactivate-hook . cursor-color-direct)
  (window-configuration-change-hook . cursor-color-toggle))

(leaf mozc-im
  :when (member system-type '(gnu gnu/linux gnu/kfreebsd))
  :ensure t
  :require t
  :custom
  (default-input-method . "japanese-mozc-im")
  (mozc-candidate-style . 'echo-area)
  :defun mozc-session-sendkey
  :config
  (defun mozc-ime-on (&rest args)
    "Google日本語入力/Mozcにキーを与えることで変換状態をonにします。"
    (when (eq (nth 0 args) 'CreateSession)
      (mozc-session-sendkey '(Henkan))))
  (when system-type-wsl
    (advice-add 'mozc-session-execute-command :after 'mozc-ime-on)))

(leaf tr-ime
  :doc "C-mでの確定にはEmacs側で対応していないのでKeyhacなどでの対処が必要"
  :when (eq window-system 'w32)
  :ensure t
  :require t
  :defun tr-ime-advanced-install w32-ime-initialize wrap-function-to-control-ime
  :defvar w32-ime-mode-line-state-indicator-list
  :config
  (tr-ime-advanced-install)
  ;; IM のデフォルトを IME に設定
  (setq default-input-method "W32-IME")
  ;; IME のモードライン表示設定
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  ;; IME 初期化
  (w32-ime-initialize)
  ;; IME 制御（yes/no などの入力の時に IME を off にする）
  (wrap-function-to-control-ime 'universal-argument t nil)
  (wrap-function-to-control-ime 'read-string nil nil)
  (wrap-function-to-control-ime 'read-char nil nil)
  (wrap-function-to-control-ime 'read-from-minibuffer nil nil)
  (wrap-function-to-control-ime 'y-or-n-p nil nil)
  (wrap-function-to-control-ime 'yes-or-no-p nil nil)
  (wrap-function-to-control-ime 'map-y-or-n-p nil nil)
  (modify-all-frames-parameters '((ime-font . "HackGenNerd-13.5"))))

(leaf *wsl
  :leaf-autoload nil
  :when system-type-wsl
  :custom
  (browse-url-generic-program . "wsl-open")
  (browse-url-browser-function . 'browse-url-generic))

;; 有効にするだけの短いコード

(leaf auto-sudoedit :ensure t :config (auto-sudoedit-mode 1))
(leaf editorconfig :ensure t :diminish "EDITC" :custom (editorconfig-mode . 1))
(leaf google-this :ensure t)
(leaf multiple-cursors :ensure t)
(leaf ncaq-emacs-utils :el-get ncaq/ncaq-emacs-utils :require t)
(leaf point-undo :el-get ncaq/point-undo :require t)
(leaf symbolword-mode :ensure t :require t)
(leaf which-key :ensure t :custom (which-key-mode . 1))

;;; テキストを超えたプログラミング機能

(leaf quickrun
  :ensure t
  :after t
  :config
  (quickrun-add-command "haskell"
    '((:command . "stack runghc")
      (:description . "Run Haskell file with Stack runghc(GHC)"))
    :override t))

(leaf flycheck
  :ensure t
  :custom
  (global-flycheck-mode . t)               ; グローバルに有効にすます
  (flycheck-display-errors-function . nil) ; Echoエリアにエラーを表示しない
  :defvar
  flycheck-error-list-format
  :init
  (defun flycheck-error-list-mode-setup ()
    ;; levelを幅10に、idを幅20にします。
    ;; flycheck-error-list-formatがdefconstなので強引に変更せざるを得ません。
    (setf (cadr (aref flycheck-error-list-format 3)) 10)
    (setf (cadr (aref flycheck-error-list-format 4)) 20))
  :hook (flycheck-error-list-mode-hook . flycheck-error-list-mode-setup)
  :bind (:flycheck-mode-map
         ("C-z" . flycheck-list-errors)
         ([remap previous-error] . flycheck-previous-error)
         ([remap next-error] . flycheck-next-error)))

(leaf lsp-mode
  :ensure t
  :after t
  :defun lsp-enable-which-key-integration
  :defvar lsp-command-map lsp-signature-mode-map
  :custom
  (lsp-auto-guess-root . t)             ; 自動的にimportする
  (lsp-enable-snippet . nil)            ; 補完からスニペット展開をするのを無効化
  (lsp-file-watch-threshold . 10000)    ; 監視ファイル警告を緩める
  (lsp-keymap-prefix . "M-z")           ; s-lだとデスクトップがロックされてしまうので変更
  (lsp-lens-mode . t)                   ; lens機能の有効化
  (lsp-prefer-flymake . nil)            ; flycheckを優先する
  (read-process-output-max . 1048576)   ; プロセスから読み込む量を増やす
  :init
  (defun lsp-format-before-save ()
    "保存する前にフォーマットする"
    (add-hook 'before-save-hook 'lsp-format-buffer nil t))
  :bind (:lsp-mode-map
         ("C-S-SPC" . nil)
         ("C-c C-a" . lsp-execute-code-action)
         ("C-c C-i" . lsp-format-region)
         ("C-c C-n" . lsp-rename)
         ("C-c C-r" . lsp-workspace-restart)
         ("C-c C-t" . lsp-describe-thing-at-point))
  :config
  ;; lsp-keymap-prefixはドキュメント用なのでこちらでの設定も必要。
  ;; bindだとうまく行かなかった。
  (define-key lsp-mode-map (kbd "M-z") lsp-command-map)
  (dvorak-set-key-prog lsp-signature-mode-map)
  (leaf lsp-ui
    :ensure t
    :defvar lsp-ui-peek-mode-map
    :custom
    (lsp-ui-doc-header . t)             ; 何を見ているのかわからなくなりがちなので名前が含まれるヘッダも表示
    (lsp-ui-doc-include-signature . t)  ; シグネチャも表示する
    (lsp-ui-doc-position . 'bottom)     ; カーソル位置はコード、上はflycheckにかぶさるので下
    (lsp-ui-sideline-enable . nil)      ; エラーはflycheckで出して型はdocで出すので幅を取るサイドラインは不要
    :bind (:lsp-ui-mode-map
           ("C-c C-d" . lsp-ui-doc-show)  ; 手動でドキュメントを表示するコマンド
           ([remap smart-jump-go] . lsp-ui-peek-find-definitions)
           ([remap smart-jump-references] . lsp-ui-peek-find-references)
           ("C->" . lsp-find-type-definition)
           ("C-c C-p" . lsp-ui-peek-find-implementation))
    :config (dvorak-set-key-prog lsp-ui-peek-mode-map))
  (leaf dap-mode
    :ensure t
    :hook
    (lsp-mode-hook . dap-mode)
    (lsp-mode-hook . dap-ui-mode)))

;;; 各言語モード

;; 一行で収まる他と関連性の薄いもの

(leaf apache-mode :ensure t)
(leaf bnf-mode :ensure t)
(leaf conf-mode :mode "/credentials$" "\\.accept_keywords$" "\\.dsk$" "\\.keywords$" "\\.license$" "\\.mask$" "\\.unmask$" "\\.use$")
(leaf csharp-mode :ensure t)
(leaf csv-mode :ensure t)
(leaf dotenv-mode :ensure t :mode "\\.env\\..*\\'")
(leaf egison-mode :ensure t :mode ("\\.egi$" . egison-mode))
(leaf envrc :ensure t)
(leaf generic-x :require t)
(leaf go-mode :ensure t :hook (go-mode-hook . lsp))
(leaf julia-mode :ensure t)
(leaf make-mode :after t :defvar makefile-mode-map :config (dvorak-set-key-prog makefile-mode-map))
(leaf mediawiki :ensure t :mode "\\.wiki$")
(leaf nginx-mode :ensure t)
(leaf opascal-mode :mode "\\.dfm$" "\\.pas$")
(leaf pascal :after t :defvar pascal-mode-map :config (dvorak-set-key-prog pascal-mode-map))
(leaf powershell :ensure t)
(leaf prolog :after t :defvar prolog-mode-map :config (dvorak-set-key-prog prolog-mode-map))
(leaf robots-txt-mode :ensure t)
(leaf ssh-config-mode :ensure t :mode "\\.ssh/config$" "sshd?_config$")
(leaf systemd :ensure t)

;;; C/C++

(leaf cc-mode
  :defvar c-mode-base-map
  :hook
  ((c-mode-hook . lsp)
   (c++-mode-hook . lsp))
  :config
  (leaf ccls :ensure t)
  (leaf clang-format
    :ensure t
    :init
    (defun set-hook-after-save-clang-format ()
      (add-hook 'after-save-hook 'clang-format-buffer t t))
    :hook ((c-mode-hook . set-hook-after-save-clang-format)
           (c++-mode-hook . set-hook-after-save-clang-format))
    :bind ((:c-mode-map ([remap indent-whole-buffer] . clang-format-buffer))
           (:c++-mode-map ([remap indent-whole-buffer] . clang-format-buffer))))
  (dvorak-set-key-prog c-mode-base-map))

;;; D

(leaf d-mode
  :ensure t
  :after cc-vars
  :defvar c-default-style
  :config
  (add-to-list 'c-default-style '(d-mode . "java"))
  (leaf dfmt
    :ensure t
    :after d-mode
    :bind (:d-mode-map
           ([remap indent-whole-buffer] . dfmt-buffer)
           ([remap save-buffer] . dfmt-save-buffer)))
  (leaf company-dcd
    :ensure t
    :hook (d-mode-hook . company-dcd-mode)
    :bind (:company-dcd-mode-map
           ("C-c ," . nil)
           ("C-c ." . nil)
           ("C-c ?" . nil)
           ("C-c s" . nil)
           ("C-c C-d" . company-dcd-show-ddoc-with-buffer)
           ("M-." . company-dcd-goto-definition))))

;;; Docker

(leaf dockerfile-mode :ensure t)

(leaf docker-compose-mode :ensure t)

;;; ebuild

(leaf ebuild-mode
  :defvar sh-basic-offset
  :init
  (defun ebuild-mode-setup ()
    (setq-local sh-basic-offset 4))     ; ebuildのインデントは伝統的に4
  :hook (ebuild-mode-hook . ebuild-mode-setup))

;;; Emacs Lisp

(leaf elisp-mode
  :custom (flycheck-emacs-lisp-load-path . 'inherit)
  :bind (:emacs-lisp-mode-map
         ("C-M-q" . nil)
         ("C-c C-e" . macrostep-expand))
  :config
  (leaf elisp-slime-nav
    :ensure t
    :bind (:elisp-slime-nav-mode-map ("C-c C-d" . helpful-at-point))
    :hook emacs-lisp-mode-hook help-mode-hook)
  (leaf eldoc :hook emacs-lisp-mode-hook ielm-mode-hook)
  (leaf flycheck-package :ensure t :after flycheck :defun flycheck-package-setup :config (flycheck-package-setup))
  (leaf ielm :bind (:ielm-map ("C-c C-d" . helpful-at-point)))
  (leaf macrostep :ensure t)
  (leaf simple :bind (:read-expression-map ("<tab>" . completion-at-point))))

;;; Elm

(leaf elm-mode
  :ensure t
  :hook
  (elm-mode-hook . lsp)
  (elm-mode-hook . lsp-format-before-save)
  :bind (:elm-mode-map
         ("C-c C-f" . nil)
         ;; elm-format-bufferの方はnpmのプロジェクト固有のelm-formatを検知しないのでlspを使います。
         ([remap indent-whole-buffer] . lsp-format-buffer)))

;;; Graphviz

(leaf graphviz-dot-mode
  :ensure t
  :custom
  (graphviz-dot-auto-indent-on-semi . nil) ; dotファイルで自動セミコロン挿入しない
  (graphviz-dot-indent-width . 2))

;;; Haskell

(leaf haskell-mode
  :ensure t
  :after t
  :defvar flycheck-error-list-buffer
  :custom
  (haskell-hoogle-command . nil)
  (haskell-hoogle-url . "https://www.stackage.org/lts/hoogle?q=%s")
  :init
  (defun haskell-repl-and-flycheck ()
    (interactive)
    (delete-other-windows)
    (flycheck-list-errors)
    (haskell-process-load-file)
    (haskell-interactive-switch)
    (split-window-below)
    (other-window 1)
    (switch-to-buffer flycheck-error-list-buffer)
    (other-window 1))
  :bind (:haskell-mode-map
         ("M-i" . stylish-haskell-toggle)
         ("C-M-z" . haskell-repl-and-flycheck)
         ("C-c C-b" . haskell-hoogle)
         ("C-c C-c" . haskell-session-change-target)
         ("C-c C-l" . haskell-process-load-file)
         ("C-c C-z" . haskell-interactive-switch)
         ([remap indent-whole-buffer] . haskell-mode-stylish-buffer))
  :config
  (leaf lsp-haskell
    :ensure t
    :hook (haskell-mode-hook . lsp)
    :custom
    ;; フォーマッターをfourmoluにします。fourmoluのデフォルト値も気に入らないがカスタマイズ出来るだけマシ。
    (lsp-haskell-formatting-provider . "fourmolu")
    ;; 補完時にスニペット展開(型が出てくるやつ)を行わないようにします。
    (lsp-haskell-completion-snippets-on . nil)
    ;; 関数補完からの自動importはcompanyから誤爆する可能性が高すぎるので無効化します。
    (lsp-haskell-plugin-ghcide-completions-config-auto-extend-on . nil)
    ;; importされたものが出てくる機能自体の思想は分かり易くて良いのですが、スクロール周りがすごい面倒になるので無効化。
    (lsp-haskell-plugin-import-lens-code-lens-on . nil)
    :defun
    lsp-code-actions-at-point
    lsp:code-action-title
    :init
    (defun lsp-haskell-execute-code-action-add-signature ()
      "Execute code action of add signature.
Add the type signature that GHC infers to the function located below the point."
      (interactive)
      (let ((action (seq-find
                     (lambda (e) (string-prefix-p "add signature" (lsp:code-action-title e)))
                     (lsp-code-actions-at-point))))
        (if action
            (lsp-execute-code-action action)
          (message "I can't find add signature action for this point"))))
    :bind (:haskell-mode-map
           ("C-c C-o" . lsp-haskell-execute-code-action-add-signature)))
  (leaf haskell-customize
    :defvar haskell-stylish-on-save
    :init
    (eval-and-compile
      (defun stylish-haskell-enable ()
        "保存したときに自動的にstylish-haskellを適用する。"
        (interactive)
        (setq-local haskell-stylish-on-save t))
      (defun stylish-haskell-disable ()
        (interactive)
        (setq-local haskell-stylish-on-save nil))
      (defun stylish-haskell-toggle ()
        (interactive)
        (setq-local haskell-stylish-on-save (not haskell-stylish-on-save)))
      (defun stylish-haskell-setup ()
        "プロジェクトディレクトリにstylish-haskellの設定ファイルがある場合、保存したときに自動的にstylish-haskellを適用する。"
        (if (locate-dominating-file default-directory ".stylish-haskell.yaml")
            (stylish-haskell-enable)
          (stylish-haskell-disable))))
    :hook (haskell-mode-hook . stylish-haskell-setup))
  (leaf haskell-interactive-mode
    :after t
    :defvar haskell-interactive-mode-map
    :config (dvorak-set-key-prog haskell-interactive-mode-map))
  (leaf haskell-cabal
    :defvar haskell-cabal-mode-map
    :config (dvorak-set-key-prog haskell-cabal-mode-map)))

(leaf shakespeare-mode :ensure t)

;;; Java

(leaf lsp-java :ensure t :hook (java-mode-hook . lsp))

(leaf groovy-mode :ensure t)

;;; Markdown

(leaf markdown-mode
  :ensure t
  :after t
  :custom
  (markdown-fontify-code-blocks-natively . t)
  (markdown-hide-urls . nil)
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
        ("pl6" . raku-mode)
        ("py" . python-mode)
        ("rb" . ruby-mode)
        ("rs" . rustic-mode)
        ("sqlite3" . sql-mode)
        ("ts" . web-mode)
        ("tsx" . web-mode)
        ("yaml". yaml-mode)
        ("zsh" . sh-mode))
      markdown-code-lang-modes)))
  (dvorak-set-key-prog markdown-mode-map))

;;; OCaml

(leaf tuareg
  :ensure t
  :mode ("\\.ml[iylp]?$" . tuareg-mode)
  :config
  (leaf merlin
    :ensure t
    :defvar merlin-mode-map
    :hook
    (tuareg-mode-hook . merlin-mode)
    :config
    (leaf merlin-company
      :ensure t
      :require t)
    (leaf merlin-eldoc
      :ensure t
      :require t
      :hook
      (merlin-mode-hook . merlin-eldoc-setup)))
  (leaf ocamlformat
    :ensure t
    :custom
    (ocamlformat-enable 'enable-outside-detected-project)
    :init
    (defun ocamlformat-setup ()
      (add-hook 'before-save-hook 'ocamlformat-before-save nil t))
    :hook
    (tuareg-mode-hook . merlin-mode))
  (leaf utop
    :ensure t
    :hook
    (tuareg-mode-hook . utop-minor-mode)))

(leaf dune
  :ensure t
  :config
  (leaf dune-format
    :ensure t
    :hook
    (dune-mode-hook . dune-format-on-save-mode)))

;;; Python

(leaf python
  :custom
  (python-indent-guess-indent-offset-verbose . nil)
  (python-shell-interpreter . "jupyter")
  (python-shell-interpreter-args . "console --simple-prompt")
  (python-shell-prompt-detect-failure-warning . nil)
  :config
  (leaf elpy
    :ensure t
    :defvar elpy-modules python-shell-completion-native-disabled-interpreters
    :defun elpy-enable
    :init (elpy-enable)
    :custom
    (elpy-rpc-python-command . "python3")
    (elpy-formatter . 'black)
    :bind (:elpy-mode-map ([remap indent-whole-buffer] . elpy-format-code))
    :config
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter"))
  (leaf python-isort
    :ensure t
    :hook (python-mode-hook . python-isort-on-save-mode))
  (leaf poetry
    :ensure t
    :commands poetry-track-virtualenv)
  (leaf pipenv
    :ensure t
    :commands pyvenv-track-virtualenv
    :defun pipenv-projectile-after-switch-extended
    :custom
    (pipenv-projectile-after-switch-function . #'pipenv-projectile-after-switch-extended)
    :config
    (add-to-list 'python-shell-completion-native-disabled-interpreters "pipenv"))
  (leaf lsp-pyright
    :ensure t
    :defvar
    lsp-pyright-venv-path
    python-shell-interpreter
    python-shell-interpreter-args
    python-shell-virtualenv-root
    pyvenv-activate
    :defun
    pipenv--force-wait
    pipenv-venv
    poetry-track-virtualenv
    pyvenv-track-virtualenv
    :init
    (defun lsp-pyright-setup ()
      "文脈に応じたPython環境のセットアップを行います。
poetryなどの自動的なトラッキングを使わずにマニュアルで有効にしてからlanguage serverを起動します。
そうしないとlsp-pyright-venv-pathに入る値が空になってしまうことがあるためです。
"
      (cond
       ;; poetry環境
       ((locate-dominating-file default-directory "pyproject.toml")
        (poetry-track-virtualenv)
        (setq-local lsp-pyright-venv-path python-shell-virtualenv-root)
        (lsp))
       ;; Pipenv環境
       ((locate-dominating-file default-directory "Pipfile")
        (pyvenv-track-virtualenv)
        (pipenv--force-wait (pipenv-venv))
        (when python-shell-virtualenv-root
          (setq-local pyvenv-activate (directory-file-name python-shell-virtualenv-root))
          (setq-local python-shell-interpreter "pipenv")
          (setq-local python-shell-interpreter-args "run jupyter console --simple-prompt")
          (setq-local lsp-pyright-venv-path python-shell-virtualenv-root))
        (lsp))
       (t
        (lsp))))
    :hook (python-mode-hook . lsp-pyright-setup)))

(leaf ein :ensure t)

;;; Raku

(leaf raku-mode
  :ensure t
  :custom (raku-indent-offset . 2)
  :config (leaf flycheck-raku :ensure t :require t))

;;; Ruby

(leaf ruby-mode
  :defvar ruby-mode-map
  :custom (ruby-insert-encoding-magic-comment . nil)
  :hook (ruby-mode-hook . lsp)
  :config
  (dvorak-set-key-prog ruby-mode-map)
  (leaf inf-ruby
    :ensure t
    :hook (ruby-mode-hook . inf-ruby-minor-mode)))

;;; Rust

(leaf rustic
  :ensure t
  :mode "\\.rs$"
  :custom
  (rustic-format-display-method . 'ignore) ; Rustfmtのメッセージをポップアップしない
  (rustic-format-trigger . 'on-save)
  :after flycheck
  :defvar flycheck-checkers
  :config
  (push 'rustic-clippy flycheck-checkers))

;;; Scala

(leaf scala-mode
  :ensure t
  :hook
  (scala-mode-hook . lsp)
  (scala-mode-hook . lsp-format-before-save)
  :config
  (leaf lsp-metals :ensure t :require t)
  (leaf smartparens :config (sp-local-pair 'scala-mode "{" nil :post-handlers nil)))

(leaf sbt-mode
  :ensure t
  :commands sbt-start sbt-command
  :bind (:sbt:mode-map ("M-t" . comint-previous-input))
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (defvar sbt:program-options '("-Dsbt.supershell=false")))

;; Sh Shell

(leaf sh-script
  :custom (sh-basic-offset . 2)
  :config
  (leaf sh :mode "\\.zsh$"))

;; VB

(leaf visual-basic-mode
  :el-get emacsmirror/visual-basic-mode
  :mode "\\.\\(?:frm\\|\\(?:ba\\|cl\\|vb\\)s\\)\\'"
  :custom
  (visual-basic-capitalize-keywords-p . nil) ; 文字列リテラルの内部の名前まで変更してしまうのでオフにします
  (visual-basic-mode-indent . 4)             ; editorconfigに認識させようとしたのですがうまく行かなかったので固定設定
  :defvar visual-basic-mode-map
  :bind (:visual-basic-mode-map ("C-i" . nil))
  :config
  (leaf smartparens :config (sp-local-pair 'visual-basic-mode "'" "'" :actions nil))
  (dvorak-set-key-prog visual-basic-mode-map))

;;; Web

(leaf add-node-modules-path :ensure t)

(leaf prettier-js
  :ensure t
  :defun add-node-modules-path
  :init
  (defun prettier-js-mode-toggle-setup ()
    "prettier-js-modeの有効無効キーバインドをprettier-js-modeが有効に出来るモードで使えるようにします。"
    (interactive)
    (add-node-modules-path)
    ;; 全体フォーマットをEmacsではなくprettierが行うように
    (local-set-key [remap indent-whole-buffer] 'prettier-js)
    ;; M-iでprettierの一時的無効化が出来るように
    (local-set-key (kbd "M-i") 'prettier-js-mode)
    ;; prettierを有効化
    (prettier-js-mode t)))

(leaf web-mode
  :ensure t
  :defvar lsp-enabled-clients web-mode-comment-formats
  :defun sp-local-pair
  :mode
  "\\.[agj]sp\\'"
  "\\.as[cp]x\\'"
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
  "\\.tsx?\\'"
  "\\.vue\\'"
  ;; js-modeが指定されているインタプリタにおいてweb-modeが指定されるようにします。
  :interpreter
  `,(seq-filter 'stringp (seq-map (lambda (regex-mode) (pcase regex-mode (`(,regex . js-mode) regex))) interpreter-mode-alist))
  :init
  (defun web-mode-setup ()
    (setq-local lsp-enabled-clients '(ts-ls eslint))
    (lsp)
    (prettier-js-mode-toggle-setup))
  :hook (web-mode-hook . web-mode-setup)
  :custom
  (web-mode-code-indent-offset . 2)
  (web-mode-css-indent-offset . 2)
  (web-mode-enable-auto-indentation . nil)
  (web-mode-enable-auto-quoting . nil)
  (web-mode-enable-current-column-highlight . t)
  (web-mode-enable-current-element-highlight . t)
  (web-mode-markup-indent-offset . 2)
  :custom-face
  (web-mode-jsx-depth-1-face . '((t (:background "#073844"))))
  (web-mode-jsx-depth-2-face . '((t (:background "#083C49"))))
  (web-mode-jsx-depth-3-face . '((t (:background "#08404F"))))
  (web-mode-jsx-depth-4-face . '((t (:background "#094554"))))
  (web-mode-jsx-depth-5-face . '((t (:background "#0A4D5E"))))
  :bind
  (:web-mode-map ([remap comment-indent-new-line] . web-mode-comment-indent-new-line))
  :config
  ;; コメントを`/*'式から`//'形式にする。
  (add-to-list 'web-mode-comment-formats '("javascript" . "//"))
  (sp-local-pair 'web-mode "<" ">" :actions nil))

(leaf yarn-mode :ensure t)

(leaf js :custom (js-indent-level . 2))

(leaf ts-comint :ensure t)

(leaf json-mode :hook (json-mode-hook . lsp) (json-mode-hook . prettier-js-mode-toggle-setup))
(leaf yaml-mode :ensure t :hook (yaml-mode-hook . prettier-js-mode-toggle-setup))

(leaf css-mode
  :custom (css-indent-offset . 2)
  :hook (css-mode-hook . lsp) ((css-mode-hook scss-mode-hook) . prettier-js-mode-toggle-setup))
(leaf less-css-mode :hook (less-css-mode-hook . prettier-js-mode-toggle-setup))

(leaf nxml-mode
  :mode "\\.fxml\\'"
  :defvar nxml-mode-map
  :custom (nxml-slash-auto-complete-flag . t)
  :bind (:nxml-mode-map
         ("M-h" . nil)
         ("C-M-t" . nil)
         ("C-M-p" . nxml-backward-element))
  :config
  (leaf smartparens :config (sp-local-pair 'nxml-mode "<" ">" :actions nil))
  (dvorak-set-key-prog nxml-mode-map))

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obsolete)
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
