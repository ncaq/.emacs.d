;; -*- lexical-binding: t -*-

;;; package管理システムの初期設定

;; package.el
(customize-set-variable
 'package-archives '(("melpa"  . "https://melpa.org/packages/")
                     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                     ("gnu"    . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; leaf.el
(eval-and-compile
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))
  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf blackout :ensure t)
    (leaf diminish :ensure t)
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf leaf-tree :ensure t)
(leaf leaf-convert :ensure t)

(leaf cus-edit
  :doc "init.elに自動的に書き込ませない。
  書き出し先は雑に決定している。
  基本的に書き出さないで良いが、
  稀にGUIなどから値を設定したいときがあるかもしれないので/dev/nullにはしないでいる。"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el")))) ;

(leaf package
  :init
  (defun package-menu-mode-setup ()
    "パッケージ名の幅を広く取る。"
    (setf (cadr (aref tabulated-list-format 0)) 50))
  (defun package-load-path-native-compile-async (&rest _)
    "だいたいのパッケージをネイティブコンパイルする。
  最初に読み込むより先にコンパイルすることにより、更新後のストレスなどを抑える。"
    (interactive)
    (native-compile-async load-path 'recursively))
  :hook (package-menu-mode-hook . package-menu-mode-setup)
  :advice (:after package-install package-load-path-native-compile-async))

;;; 初期化

(leaf exec-path-from-shell
  :doc "Windowsのwslg.exeやmacOSのランチャーなどから起動したときはシェルの環境変数を引き継がないため、
Emacs側でシェルを読み込む。"
  :ensure t
  :when window-system
  ;; wslg.exeでshell-typeをnoneにすると何故かここで新しいインスタンスが起動してループするため注意。
  :config (exec-path-from-shell-initialize))

(leaf startup
  :custom
  (inhibit-startup-screen . t)      ; スタートアップ画面を出さない
  (mail-host-address . "ncaq.net")) ; これでuser-mail-addressも設定されます

(leaf editfns
  :doc "WSL2 + Ubuntuなどだと環境変数`NAME'が`hostname'と同じ値になってしまい、
`user-full-name'がそれ由来になることを回避します。"
  :custom `(user-full-name . ,user-login-name))

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  "バッファが存在すればkillする. 無ければ何もしない."
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

;; 起動時に作られる使わないバッファを削除する
(kill-buffer-if-exist "*scratch*")

(leaf server :global-minor-mode t)

;;; ある程度独立した定義

(leaf f
  :ensure t
  :require t
  :defun f-file? f-read-text
  :config
  (defconst system-type-wsl
    (let ((osrelease-file "/proc/sys/kernel/osrelease"))
      (and
       (eq system-type 'gnu/linux)
       (f-file? osrelease-file)
       (string-match-p "WSL" (f-read-text osrelease-file))))
    "EmacsがWSLで動いているか?"))

(defun open-home ()
  (interactive)
  (find-file "~/"))

(defun open-desktop ()
  (interactive)
  (find-file "~/Desktop/"))

(defun open-downloads ()
  (interactive)
  (find-file "~/Downloads/"))

(defun open-google-drive ()
  (interactive)
  (find-file "~/GoogleDrive/"))

(defun open-win-downloads ()
  (interactive)
  (find-file "~/WinDownloads/"))

(defun open-document-current ()
  (interactive)
  (let ((find-file-visit-truename t))
    (find-file "~/Documents/current/")))

(defun open-ncaq-entry ()
  (interactive)
  (find-file "~/Desktop/www.ncaq.net/site/entry/"))

(defun open-ncaq-entry-current-time ()
  (interactive)
  (find-file (concat
              "~/Desktop/www.ncaq.net/site/entry/"
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
  ("<tab>" . indent-for-tab-command) ; <tab>に何かしらを割り当てることでC-iと別扱いになります

  ("C-'" . mc/mark-all-dwim)
  ("C-+" . text-scale-increase)
  ("C-," . off-input-method)
  ("C--" . text-scale-decrease)
  ("C-." . on-input-method)
  ("C-;" . string-inflection-dwim-style-cycle)
  ("C-=" . text-scale-reset)
  ("C-^" . dired-jump)
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

  ("M-'" . er/expand-region)
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
  ("M-q" . delete-other-windows-force)
  ("M-r" . revert-buffer-safe-confirm)
  ("M-t" . scroll-down-one)
  ("M-u" . duplicate-dwim)
  ("M-w" . kill-ring-save-region-or-symbol-at-point)
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)

  ("C-M-'" . mc/edit-lines)
  ("C-M-," . helm-imenu)
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
  ("C-c E" . open-ncaq-entry)
  ("C-c a" . open-downloads)
  ("C-c c" . quickrun)
  ("C-c d" . docker)
  ("C-c e" . open-ncaq-entry-current-time)
  ("C-c g" . open-google-drive)
  ("C-c h" . open-home)
  ("C-c i" . open-win-downloads)
  ("C-c j" . rg)
  ("C-c o" . open-desktop)
  ("C-c p" . package-list-packages)
  ("C-c r" . recentf-cleanup)
  ("C-c s" . customize-set-variable)
  ("C-c u" . open-document-current)
  ("C-c v" . envrc-allow)

  ("C-x d" . mark-defun)
  ("C-x g" . insert-random-uuid)
  ("C-x p" . mark-paragraph)
  ("C-x t" . insert-iso-datetime)
  ("C-x w" . mark-whole-word)
  ("C-x x" . mark-whole-sexp)

  ("C-c C-;" . align-space)

  ("C-x C-f" . helm-find-files)

  ("<help> c" . helpful-command)
  ("<help> w" . helm-man-woman)

  ("C-x <RET> u" . revert-buffer-with-coding-system-utf-8-unix)
  ("C-x <RET> s" . revert-buffer-with-coding-system-japanese-cp932-dos))

;;; 見た目

(leaf *font
  :config
  (defun font-setup ()
    (set-face-attribute
     'default
     nil
     :family "HackGen Console NF"
     ;; 2画面分割でだいたい横120文字を表示できるフォントサイズにする。
     ;; フルHDと4Kを想定。
     :height (if (<= (frame-pixel-width) 1920) 108 130))
    (set-fontset-font t 'unicode (font-spec :name "HackGen Console NF") nil 'append)
    (unless (eq system-type 'darwin)
      (set-fontset-font t '(#x1F000 . #x1FAFF) (font-spec :name "Noto Color Emoji") nil 'append)))
  ;; `frame-pixel-width'がフレーム作成後でないと実用的な値を返さないので、
  ;; 初期化後にフォントサイズを設定します。
  (add-hook 'after-init-hook 'font-setup))

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
(leaf volatile-highlights :ensure t :global-minor-mode t :blackout t)

;; 置換の動きを可視化
(leaf anzu
  :ensure t
  :global-minor-mode global-anzu-mode
  :blackout t
  :bind
  ([remap query-replace] . anzu-query-replace)
  ([remap query-replace-regexp] . anzu-query-replace-regexp))

;;; History

(leaf recentf
  :custom
  ((recentf-max-saved-items . 2000)
   (recentf-exclude . '("\\.elc$" "\\.o$" "~$" "\\.file-backup/" "\\.undo-tree/" "EDITMSG" "PATH" "TAGS" "autoloads"))))

(leaf recentf-ext :ensure t :after docker-tramp :require t)
(leaf recentf-remove-sudo-tramp-prefix :ensure t :global-minor-mode t :blackout t)

(leaf savehist :global-minor-mode t)

(leaf desktop
  :global-minor-mode desktop-save-mode
  :defvar desktop-minor-mode-table
  :custom
  (desktop-globals-to-save . nil)
  (desktop-restore-frames . nil))

(leaf save-place-mode :global-minor-mode t)

(leaf files
  :custom
  ;; バックアップ先をカレントディレクトリから変更
  (backup-directory-alist . `(("." . ,(concat user-emacs-directory "file-backup/"))))
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

(leaf tramp :custom (tramp-allow-unsafe-temporary-files . t)) ; バックアップファイルをroot絡みでも自動許可する。
(leaf filelock :custom (create-lockfiles . nil)) ; percelがバグるのでロックファイルとしてシンボリックリンクを作らない

;;; toolkit

(leaf frame
  :doc "全画面化。"
  :init
  (eval-and-compile
    (defun frame-maximized ()
      "画面を全画面化する(not fullscreen)。
`toggle-frame-maximized'のトグルじゃないバージョン。"
      (interactive)
      (set-frame-parameter nil 'fullscreen 'maximized)))
  :config (frame-maximized))

(leaf image-file :global-minor-mode auto-image-file-mode)

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

;;; Emacs内部でだいたい収まる機能の設定

(leaf *c-source-code
  :custom
  (delete-by-moving-to-trash . t)             ; ごみ箱を有効
  (indent-tabs-mode . nil)                    ; インデントをスペースで行う
  (message-log-max . 100000)                  ; メッセージをたくさん残す
  (read-buffer-completion-ignore-case . t)    ; 大文字と小文字を区別しない バッファ名
  (read-file-name-completion-ignore-case . t) ; 大文字と小文字を区別しない ファイル名
  (read-process-output-max . 1048576)         ; プロセスから一度に読み込む量を増やす
  (scroll-conservatively . 1)                 ; 最下段までスクロールした時のカーソルの移動量を減らす
  (scroll-margin . 5))                        ; 最下段までスクロールしたという判定を伸ばす

(leaf mule-cmds
  :doc "Windowsなどでも優先してUTF-8を使うための設定。"
  :config
  (set-default-coding-systems 'utf-8-unix)
  (prefer-coding-system 'utf-8))

(leaf simple
  :custom
  (blink-matching-paren . nil)          ; 括弧移動無効
  (kill-ring-max . 600)) ; メモリに余裕があるのでクリップボードの履歴数を増やす

(leaf autorevert :global-minor-mode global-auto-revert-mode) ; 自動再読込
(leaf executable :hook (after-save-hook . executable-make-buffer-file-executable-if-script-p)) ; スクリプトに実行権限付加
(leaf files :custom (require-final-newline . t)) ; ファイルの最後に改行
(leaf indent :custom (standard-indent . 2)) ; 標準インデント値を出来るだけ2にする
(leaf novice :custom (disabled-command-function . nil)) ; 初心者向けに無効にされているコマンドを有効にする
(leaf select :custom (select-enable-clipboard . t)) ; クリップボードをX11と共有
(leaf subr :config (fset 'yes-or-no-p 'y-or-n-p)) ; "yes or no"を"y or n"に
(leaf vc-hooks :custom (vc-follow-symlinks . t)) ; 常にシンボリックリンクをたどる
(leaf warnings :custom (warning-minimum-level . :error)) ; 警告はエラーレベルでないとポップアップ表示しない

(leaf dired
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
         ("C-^" . dired-jump)
         ("C-c C-t" . wdired-change-to-wdired-mode))
  :config (dvorak-set-key-prog dired-mode-map))

(leaf helm
  :ensure t
  :global-minor-mode t
  :blackout t
  :custom
  ;; モードを短縮する基準
  (helm-buffer-max-len-mode . 25)
  ;; デフォルトはファイル名を短縮する区切りが20
  (helm-buffer-max-length . 50)
  ;; デフォルトは50で全体画面表示するから足りない
  (helm-candidate-number-limit . 200)
  ;; kill-line sim
  (helm-delete-minibuffer-contents-from-point . t)
  ;; helm-find-filesにrecentfを使用する
  (helm-ff-file-name-history-use-recentf . t)
  ;; ウインドウ全体に表示
  (helm-full-frame . t)
  ;; `helm-for-files'を多用するためソースは`helm-next-line'などで移動したい。
  (helm-move-to-line-cycle-in-source . nil)
  :defvar helm-for-files-preferred-list
  :init
  (defun helm-for-files-prefer-recentf ()
    "recentfを優先する`helm-for-files'。"
    (interactive)
    (let ((helm-for-files-preferred-list
           '(helm-source-buffers-list
             helm-source-recentf
             helm-source-ls-git
             helm-source-locate)))
      (helm-for-files)))
  (defun helm-for-files-prefer-near ()
    "git管理下など近い場所のファイルを優先する`helm-for-files'。"
    (interactive)
    (let ((helm-for-files-preferred-list
           '(helm-source-buffers-list
             helm-source-ls-git
             helm-source-recentf
             helm-source-locate)))
      (helm-for-files)))
  :bind (:helm-map
         ("C-M-b" . nil)
         ("C-b" . nil)
         ("C-h" . nil)
         ("C-s" . nil)
         ("M-b" . nil)
         ("M-s" . nil)
         ("C-p" . helm-toggle-resplit-and-swap-windows)
         ("C-t" . helm-previous-line)
         ("<tab>" . helm-select-action))
  :config
  (leaf helm-buffers
    :bind (:helm-buffer-map ("C-s" . nil))
    :defvar helm-boring-buffer-regexp-list
    :config
    (mapc (lambda (regex) (add-to-list 'helm-boring-buffer-regexp-list (concat "^\\*" regex "\\*$")))
          '("Flycheck errors"
            "Flymake log"
            "WoMan-Log"
            "copilot events"
            "copilot-balancer"
            "envrc"
            "prettier.+"
            "straight-process"
            "sweep Messages"
            "tramp.+"
            "vc"

            ".+ls\\(::stderr\\)?"
            "eslint\\(::stderr\\)?"
            "lsp-.+\\(::stderr\\)?"
            "marksman\\(::stderr\\)?"
            "pyright\\(::stderr\\)?")))
  (leaf helm-files :bind (:helm-find-files-map ("C-s" . nil)))
  (leaf helm-types :bind (:helm-generic-files-map ("C-s" . nil)))
  (leaf helm-grep
    :custom
    ;; ripgrepは自動認識されるが、オプションを少し追加。
    (helm-grep-ag-command
     . "rg --color=always --smart-case --search-zip --no-heading --line-number --type-not=svg --sort=path %s -- %s %s")
    ;; 検索結果でファイル名だけではなくパスも表示する。
    (helm-grep-file-path-style . 'absolute)
    :defun project-root helm-grep-ag
    :init
    (eval-and-compile
      (defun helm-do-grep-ag-project-dir (arg)
        "プロジェクトディレクトリ以下のファイルを対象に`helm-do-grep-ag'検索を行う。"
        (interactive "P")
        (helm-grep-ag (expand-file-name (project-root (project-current))) arg))
      (defun helm-do-grep-ag-project-dir-or-fallback (arg)
        "`helm-do-grep-ag-project-dir' OR `helm-do-grep-ag'."
        (interactive "P")
        (let ((in-project (ignore-errors (project-root (project-current)))))
          (if in-project
              (helm-do-grep-ag-project-dir arg)
            (helm-do-grep-ag arg)))))
    :advice (:before helm-grep-action (lambda (&rest _ignored) (xref-push-marker-stack))))
  (leaf helm-descbinds :ensure t :global-minor-mode t)
  (leaf helm-swoop :ensure t)
  (leaf helm-ls-git
    :ensure t
    :require t
    :defvar helm-source-ls-git-status helm-source-ls-git helm-source-ls-git-buffers helm-ls-git-rebase-todo-mode-map
    :defun helm-ls-git-build-git-status-source helm-ls-git-build-ls-git-source helm-ls-git-build-buffers-source
    :config
    ;; git-commmit.elなど特化型のものが存在するためバッファ向けのモードは不要。
    (setq auto-mode-alist
          (cl-remove-if
           (lambda (pair)
             (member
              (cdr pair)
              '(helm-ls-git-commit-mode helm-ls-git-rebase-todo-mode)))
           auto-mode-alist))
    ;; helm-for-filesで出力するのには手動初期化が必要。
    (setq helm-source-ls-git-status
          (helm-ls-git-build-git-status-source)
          helm-source-ls-git
          (helm-ls-git-build-ls-git-source)
          helm-source-ls-git-buffers
          (helm-ls-git-build-buffers-source))
    (swap-set-key helm-ls-git-rebase-todo-mode-map '(("M-p" . "M-t")))))

(leaf helpful
  :ensure t
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-key]      . helpful-key)
  ([remap describe-symbol]   . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  :advice (:after helpful-at-point other-window-backward)
  :defvar helpful-mode-map
  :config (dvorak-set-key-prog helpful-mode-map))

(leaf ibuffer
  :custom `(ibuffer-formats . '((mark modified read-only " " (name 60 30) " " (size 6 -1) " " (mode 16 16) " " filename)
                                (mark " " (name 60 -1) " " filename))) ; 幅を大きくする
  :bind (:ibuffer-mode-map
         ("C-o" . nil)
         ("C-t" . nil)
         ("M-g" . nil))
  :after t
  :defvar ibuffer-mode-map
  :config (dvorak-set-key-prog ibuffer-mode-map))

(leaf profiler
  :custom (profiler-report-cpu-line-format . '((100 left) (24 right ((19 right) (5 right))))) ; 幅を大きくする
  :after t
  :defvar profiler-report-mode-map
  :config (dvorak-set-key-prog profiler-report-mode-map))

;;; ジャンプ

(leaf rg
  :ensure t
  :after t
  :defvar rg-mode-map
  :config
  (dvorak-set-key-prog rg-mode-map)
  (swap-set-key rg-mode-map '(("M-P" . "M-T"))))

(leaf xref
  :defun xref-push-marker-stack xref-set-marker-ring-length
  :config
  ;; 履歴のサイズを上げるために、
  ;; `xref-marker-ring-length'を設定したいだけですが、
  ;; 設定したタイミングでリングのサイズ変更などを行う必要があるので専用関数が用意されているようです。
  (xref-set-marker-ring-length 'xref-marker-ring-length 128))

(leaf smart-jump
  :ensure t
  :custom
  (smart-jump-find-references-fallback-function . 'smart-jump-find-references-with-rg)
  (smart-jump-refs-key . "C-M-.")
  :bind
  ("M-." . smart-jump-go)
  ("M-," . smart-jump-back)
  ("C-M-." . smart-jump-references))

;;; 補完

(leaf company
  :ensure t
  :global-minor-mode global-company-mode
  :blackout t
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
  :defvar company-backends company-search-map
  :config
  (dvorak-set-key-prog company-active-map)
  ;; company-search-mapの入力をそのまま受け付ける特殊性に対応するワークアラウンド。
  (define-key company-search-map (kbd "C-c") nil)
  (dvorak-set-key company-search-map)
  (leaf company-box
    :when window-system
    :ensure t
    :require t
    :blackout t
    :hook company-mode-hook))

(leaf copilot
  :straight (copilot :type git :host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :global-minor-mode global-copilot-mode
  :defun copilot-mode
  :init
  (defun copilot-mode-off ()
    "copilot-modeを無効にします。"
    (interactive)
    (copilot-mode -1))
  :bind (:copilot-completion-map
         ("<tab>" . copilot-accept-completion)
         ("TAB"   . copilot-accept-completion)
         ("C-M-n" . copilot-next-completion)
         ("C-M-t" . copilot-previous-completion)))

(leaf yasnippet
  :ensure t
  :global-minor-mode yas-global-mode
  :blackout yas-minor-mode
  :defun yas-expand-snippet yas-lookup-snippet
  :bind (:yas-minor-mode-map
         ("<tab>" . nil)
         ("TAB" . nil)
         ("C-c C-y" . company-yasnippet)
         ("M-z" . yas-insert-snippet))
  :config (leaf yasnippet-snippets :ensure t))

;;; テキスト処理

(leaf smartparens
  :ensure t
  :require smartparens-config
  :global-minor-mode
  smartparens-global-mode
  show-smartparens-global-mode
  :blackout t
  :custom
  (sp-escape-quotes-after-insert . nil)
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
  :defun sp-local-pair sp-pair
  :config
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
  (defun string-inflection-dwim-style-cycle ()
    "メジャーモードに従ってありえる命名候補を自動的に変更します。判断できなければ`string-inflection-all-cycle'に投げます。"
    (interactive)
    (pcase major-mode
      ;; snake_case -> PascalCase。大文字での定数も含みます。
      ((or
        'c++-mode-hook
        'c-mode
        'python-mode
        'ruby-mode
        'rust-mode
        'rustic-mode
        'tuareg)
       (string-inflection-ruby-style-cycle))
      ;; snake_case -> PascalCase。
      ('elixir-mode
       (string-inflection-elixir-style-cycle))
      ;; camelCase -> PascalCase。大文字での定数も含みます。
      ((or
        'csharp-mode
        'd-mode
        'elm-mode
        'groovy-mode
        'haskell-mode
        'java-mode
        'sbt-mode
        'scala-mode
        'web-mode)
       (string-inflection-java-style-cycle))
      ;; 全ての変換を含みます。
      (_
       (string-inflection-all-cycle)))))

(leaf undo-tree
  :ensure t
  :global-minor-mode global-undo-tree-mode
  :blackout t
  :custom
  (undo-tree-enable-undo-in-region . nil)
  (undo-tree-history-directory-alist . `(("" . ,(concat user-emacs-directory "undo-tree/"))))
  (undo-tree-visualizer-timestamps . t)
  :defvar undo-tree-visualizer-mode-map
  :config
  (dvorak-set-key-prog undo-tree-visualizer-mode-map)
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit))

(leaf whitespace
  :global-minor-mode global-whitespace-mode
  :blackout global-whitespace-mode
  :custom
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
  :defun magit-start-process
  :init
  (defun magit-find-file-to-origin-master ()
    "今いるファイルのorigin/masterのリビジョンを開く。"
    (interactive)
    (magit-find-file "origin/master" (buffer-file-name)))
  (defun magit-find-file-to-head ()
    "今いるファイルのHEADのリビジョンを開く。"
    (interactive)
    (magit-find-file "HEAD" (buffer-file-name)))
  (defun magit-diff-range-to-origin-master ()
    "今いるファイルのorigin/masterとのdiffを閲覧する。"
    (interactive)
    (magit-diff-range "origin/master" nil (list (buffer-file-name))))
  (defun magit-diff-range-to-head ()
    "今いるファイルのHEADとのdiffを閲覧する。"
    (interactive)
    (magit-diff-range "HEAD" nil (list (buffer-file-name))))
  (defun gh-pr-create-web ()
    "GitHub CLIを使ってPull Requestを作成する画面をwebで開く。
Forgeとかにも作成機能はあるが、レビュアーやラベルやProjectsの指定はwebの方が楽。"
    (interactive)
    ;; Git関係なのでMagitのProcessに履歴を残しておきたい。
    (magit-start-process "gh" nil "pr" "create" "--assignee" "@me" "--web"))
  (defun gh-repo-view-web ()
    "GitHub CLIを使って現在フォーカスしているリポジトリをwebで開きます。"
    (interactive)
    (magit-start-process "gh" nil "repo" "view" "--web"))
  :bind
  ("M-g F" . magit-pull)
  ("M-g H" . magit-diff-range-to-head)
  ("M-g M" . magit-diff-range-to-origin-master)
  ("M-g a" . magit-snapshot-both)
  ("M-g b" . magit-blame)
  ("M-g d" . magit-diff)
  ("M-g f" . magit-find-file)
  ("M-g g" . magit-dispatch)
  ("M-g h" . magit-find-file-to-head)
  ("M-g l" . magit-log-buffer-file)
  ("M-g m" . magit-find-file-to-origin-master)
  ("M-g q" . gh-pr-create-web)
  ("M-g s" . magit-status)
  ("M-g v" . gh-repo-view-web)
  ("M-g w" . magit-branch-checkout)
  ("M-g z" . magit-stash-both)
  :config
  (leaf magit-mode
    :after t
    :defvar magit-mode-map
    :config (swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf magit-diff
    :after t
    ;; `magit-diff-visit-worktree-file'は`C-<return>'でも代用出来て、検索の誤爆の原因になるので無効化する。
    :bind (:magit-diff-section-map ("C-j" . nil)))
  (leaf magit-pull :custom (magit-pull-or-fetch . t))
  (leaf magit-wip :blackout t :custom (magit-wip-mode . t))
  (leaf git-commit
    :after t
    :custom
    (git-commit-major-mode . #'markdown-mode)
    :init
    (defun yas-insert-snippet-conventional-commits-type ()
      "@commitlint/config-conventionalが受け付けるtypeを選択して入力する。"
      (interactive)
      (yas-expand-snippet (yas-lookup-snippet "conventional-commits-type")))
    :defvar git-commit-mode-map
    :bind (:git-commit-mode-map ("M-z" . yas-insert-snippet-conventional-commits-type))
    :config
    ;; コミットメッセージ編集画面での幅に基づく自動改行を無効化
    (remove-hook 'git-commit-setup-hook 'git-commit-turn-on-auto-fill)
    (modify-coding-system-alist 'file "COMMIT_EDITMSG" 'utf-8-unix)
    (swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-rebase
    :after t
    :defvar git-rebase-mode-map
    :config (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-modes :ensure t :mode ("/.dockerignore\\'" . gitignore-mode))
  (leaf forge
    :ensure t
    :require t
    :custom
    (forge-add-pullreq-refspec . nil)  ; PR作る時にrefを自動生成しない。
    (forge-post-fill-region . nil)     ; issueなどを自動改行しない。
    :defun forge-get-repository
    :init
    (defun forge-pull-when-forge-repo ()
      "forgeが設定されているリポジトリでは`forge-pull'を実行する。"
      (when (forge-get-repository nil) (forge-pull)))
    :advice (:after magit-pull forge-pull-when-forge-repo)
    :config
    (leaf sqlite3
      :unless (and (fboundp 'sqlite-available-p) (sqlite-available-p))
      :doc "Emacsのbuilt-inのSQLite機能が使えない場合、フォールバックとして有効にします。"
      :ensure t
      :require t)))

(leaf git-gutter
  :ensure t
  :global-minor-mode global-git-gutter-mode
  :blackout t
  :hook (magit-post-refresh-hook . git-gutter:update-all-windows))

(leaf git-link
  :ensure t
  :custom
  (git-link-open-in-browser . t)
  (git-link-use-commit . t)
  :bind ("M-g p" . git-link))

(leaf docker
  :ensure t
  :custom (docker-container-shell-file-name . "/bin/bash")
  :init
  (defun docker-image-mode-setup ()
    "イメージ名の幅を広く取ります。"
    (setf (cadr (aref tabulated-list-format 0)) 100))
  :hook (docker-image-mode-hook . docker-image-mode-setup))

(leaf *input-method
  :leaf-autoload nil
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
  :ensure t
  :when (member system-type '(gnu gnu/linux gnu/kfreebsd))
  :require t
  :custom
  (default-input-method . "japanese-mozc-im")
  (mozc-candidate-style . 'echo-area))

(leaf *mozc-im-wsl
  :leaf-autoload nil
  :doc "mozc_emacs_helper.exeを使って、Windows側のGoogle日本語入力と通信する。"
  ;; Windows 11 22H2からmozc_emacs_helper.exeが起動するたびにフォーカスを奪ってくるのでまともに動かない。
  ;; よって解決するまでWSL環境でもmozcで我慢する。
  ;; :when system-type-wsl
  :when nil
  :init
  (defun mozc-ime-on (&rest args)
    "Google日本語入力/Mozcにキーを与えることで変換状態をonにします。"
    (when (eq (nth 0 args) 'CreateSession)
      (mozc-session-sendkey '(Henkan))))
  :advice (:after mozc-session-execute-command mozc-ime-on))

(leaf tr-ime
  :ensure t
  :doc "C-mでの確定にはEmacs側で対応していないのでKeyhacなどでの対処が必要"
  :when (eq window-system 'w32)
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
  (modify-all-frames-parameters '((ime-font . "HackGen Console NF-13.5"))))

(leaf envrc
  :ensure t
  :global-minor-mode envrc-global-mode
  :custom (envrc-none-lighter . nil))

(leaf man
  :custom
  (Man-notify-method . 'bully)     ; Manページを現在のウィンドウで表示
  (Man-width-max . nil)            ; Manページのwidthの最大幅を除去
  :after t
  :defvar Man-mode-map
  :config (dvorak-set-key-prog Man-mode-map))

(leaf ediff
  :custom
  (ediff-split-window-function . 'split-window-horizontally)  ; ediffでウィンドウを横分割
  (ediff-window-setup-function . 'ediff-setup-windows-plain)) ; ediffにframeを生成させない

(leaf *wsl
  :leaf-autoload nil
  :when system-type-wsl
  :custom
  (browse-url-generic-program . "wslview")
  (browse-url-browser-function . 'browse-url-generic))

;; 有効にするだけの短いコード

(leaf auto-sudoedit :ensure t :global-minor-mode t :blackout t)
(leaf editorconfig :ensure t :global-minor-mode t :blackout t)
(leaf expand-region :ensure t)
(leaf google-this :ensure t)
(leaf multiple-cursors :ensure t)
(leaf ncaq-emacs-utils :straight (ncaq-emacs-utils :type git :host github :repo "ncaq/ncaq-emacs-utils") :require t)
(leaf point-undo :straight (point-undo :type git :host github :repo "ncaq/point-undo") :require t)
(leaf symbolword-mode :ensure t :require t :global-minor-mode t :blackout t)
(leaf which-key :ensure t :global-minor-mode t :blackout t)

;;; 汎用プログラミング機能

;; lspなどサーバをlocal変数を適応した後に起動し始めるのに必要。
;; 主にNode.jsとDenoの切り替えや、LSPサーバに渡すカスタム変数の変更など。
(defun run-local-vars-mode-hook ()
  "Run `major-mode' hook after the local variables have been processed."
  (run-hooks (intern (concat (symbol-name major-mode) "-local-vars-hook"))))
(add-hook 'hack-local-variables-hook 'run-local-vars-mode-hook)

(leaf lsp-mode
  :ensure t
  :preface
  ;; s-lだと大概のディスプレイマネージャでロックされてしまうので変更。
  ;; lsp-modeの何かを読み込んだ時点でdefvarでkeymapが作成されてしまうため、
  ;; 先に初期化が必要。
  (defvar lsp-keymap-prefix "C-M-z")
  :custom
  (lsp-auto-execute-action . nil)        ; アクションが1つだけでも実行するか確認する
  (lsp-auto-guess-root . t)              ; 自動的にimportする
  (lsp-enable-snippet . nil)             ; 補完からスニペット展開をするのを無効化
  (lsp-file-watch-threshold . 10000)     ; 監視ファイル警告を緩める
  (lsp-imenu-sort-methods . '(position)) ; sortがデフォルトでは種類別になっている
  :defun lsp-code-actions-at-point lsp-register-client lsp-stdio-connection lsp:code-action-title make-lsp-client
  :init
  (defun lsp-format-before-save ()
    "保存する前にフォーマットする設定を有効にする。
呼び出したバッファーでしか有効にならない。"
    (add-hook 'before-save-hook #'lsp-format-buffer nil t))
  :bind (:lsp-mode-map
         ("C-S-SPC" . nil)
         ("C-c C-a" . lsp-execute-code-action)
         ("C-c C-i" . lsp-format-region)
         ("C-c C-r" . lsp-rename)
         ("C-c C-s" . lsp-lens-mode)
         ("C-c C-t" . lsp-describe-thing-at-point)
         ("C-c C-w" . lsp-workspace-restart))
  :bind (:lsp-signature-mode-map
         ("M-n" . nil)
         ("M-p" . nil))
  :config
  (dvorak-set-key-prog lsp-signature-mode-map)
  (leaf lsp-ui
    :ensure t
    :custom
    (lsp-ui-doc-header . t)             ; 何を見ているのかわからなくなりがちなので名前が含まれるヘッダも表示
    (lsp-ui-doc-include-signature . t)  ; シグネチャも表示する
    (lsp-ui-doc-position . 'bottom)     ; カーソル位置はコード、上はflycheckにかぶさるので下
    (lsp-ui-sideline-enable . nil)      ; エラーはflycheckで出して型はdocで出すので幅を取るサイドラインは不要
    :bind (:lsp-ui-mode-map
           ("C-c C-d" . lsp-ui-doc-show)  ; 手動でドキュメントを表示するコマンド
           ([remap helm-imenu] . lsp-ui-imenu)
           ([remap smart-jump-go] . lsp-ui-peek-find-definitions)
           ([remap smart-jump-references] . lsp-ui-peek-find-references)
           ("C->" . lsp-ui-peek-find-implementation)
           ("C-c C-." . lsp-find-type-definition))
    :defvar lsp-ui-peek-mode-map
    :config (dvorak-set-key-prog lsp-ui-peek-mode-map))
  (leaf dap-mode
    :ensure t
    :hook
    (lsp-mode-hook . dap-mode)
    (lsp-mode-hook . dap-ui-mode)))

(leaf flycheck
  :ensure t
  :global-minor-mode global-flycheck-mode
  :blackout t
  :custom (flycheck-display-errors-function . nil) ; Echoエリアにエラーを表示しない。
  :bind (:flycheck-mode-map
         ("C-z" . flycheck-list-errors)
         ([remap previous-error] . flycheck-previous-error)
         ([remap next-error]     . flycheck-next-error))
  :defvar flycheck-error-list-buffer flycheck-error-list-mode-map
  :config (dvorak-set-key flycheck-error-list-mode-map))

(leaf flymake
  :bind (:flymake-mode-map
         ("C-z" . flymake-show-buffer-diagnostics)
         ([remap previous-error] . flymake-goto-prev-error)
         ([remap next-error]     . flymake-goto-next-error)))

(leaf language-detection
  :ensure t
  :init
  (defun language-detection-mode-switch ()
    "`(language-detection-buffer)'の結果に従ってモードを切り替えます。
典型的な使い方として、PerlとPrologを自動識別することを考えています。"
    (interactive)
    (let ((mode
           (pcase (language-detection-buffer)
             ('ada 'ada-mode)
             ('awk 'awk-mode)
             ('c 'c-mode)
             ('cpp 'c++-mode)
             ('clojure 'clojure-mode)
             ('csharp 'csharp-mode)
             ('css 'css-mode)
             ('dart 'dart-mode)
             ('delphi 'delphi-mode)
             ('emacslisp 'emacs-lisp-mode)
             ('erlang 'erlang-mode)
             ('fortran 'fortran-mode)
             ('fsharp 'fsharp-mode)
             ('go 'go-mode)
             ('groovy 'groovy-mode)
             ('haskell 'haskell-mode)
             ('html 'web-mode)
             ('java 'java-mode)
             ('javascript 'web-mode)
             ('json 'json-mode)
             ('latex 'latex-mode)
             ('lisp 'lisp-mode)
             ('lua 'lua-mode)
             ('matlab 'octave-mode)
             ('objc 'objc-mode)
             ('perl 'perl-mode)
             ('php 'php-mode)
             ('prolog 'sweeprolog-mode)
             ('python 'python-mode)
             ('r 'r-mode)
             ('ruby 'ruby-mode)
             ('rust 'rustic-mode)
             ('scala 'scala-mode)
             ('shell 'shell-script-mode)
             ('smalltalk 'smalltalk-mode)
             ('sql 'sql-mode)
             ('swift 'swift-mode)
             ('visualbasic 'visual-basic-mode)
             ('xml 'nxml-mode)
             (_ nil))))
      (if (not mode)
          (error "モードを推定できませんでした。")
        (if (not (fboundp mode))
            (error (concat "モードに対応する関数がインストールされていません: " mode))
          (funcall mode))))))

(leaf quickrun
  :ensure t
  :config
  (quickrun-add-command "haskell"
    '((:command . "stack runghc")
      (:description . "Run Haskell file with Stack runghc(GHC)"))
    :override t))

;;; 各言語モード

;; 一行で収まる他と関連性の薄いもの

(leaf apache-mode :ensure t)
(leaf bnf-mode :ensure t)
(leaf conf-mode :mode "/credentials$" "\\.dsk$")
(leaf csv-mode :ensure t)
(leaf dotenv-mode :ensure t)
(leaf egison-mode :ensure t :mode ("\\.egi$" . egison-mode))
(leaf generic-x :require t)
(leaf go-mode :ensure t :hook (go-mode-hook . lsp))
(leaf graphviz-dot-mode :ensure t :custom (graphviz-dot-auto-indent-on-semi . nil))
(leaf inf-lisp :custom (inferior-lisp-program . "sbcl --noinform"))
(leaf julia-mode :ensure t)
(leaf make-mode :after t :defvar makefile-mode-map :config (dvorak-set-key-prog makefile-mode-map))
(leaf mediawiki :ensure t :mode "\\.wiki$")
(leaf nginx-mode :ensure t)
(leaf opascal-mode :mode "\\.dfm$" "\\.pas$")
(leaf pascal :after t :defvar pascal-mode-map :config (dvorak-set-key-prog pascal-mode-map))
(leaf plantuml-mode :ensure t :mode "\\.puml$" :custom (plantuml-default-exec-mode . 'executable))
(leaf robots-txt-mode :ensure t)
(leaf scheme :custom (scheme-program-name . "gosh"))
(leaf ssh-config-mode :ensure t :mode "\\.ssh/config$" "sshd?_config$")
(leaf systemd :ensure t)

;;; C/C++

(leaf cc-mode
  :defvar c-mode-base-map c-default-style
  :hook
  ((c-mode-hook . lsp)
   (c++-mode-hook . lsp))
  :config
  (dvorak-set-key-prog c-mode-base-map)
  (leaf ccls :ensure t))

;;; D

(leaf d-mode
  :ensure t
  :after cc-vars
  :config
  (add-to-list 'c-default-style '(d-mode . "java"))
  (leaf dfmt
    :ensure t
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
  :init
  (defun ebuild-mode-setup ()
    (setq-local sh-basic-offset 4))     ; ebuildのインデントは伝統的に4
  :hook (ebuild-mode-hook . ebuild-mode-setup))

;;; Emacs Lisp

(leaf elisp-mode
  :custom (flycheck-emacs-lisp-load-path . 'inherit)
  :bind (:emacs-lisp-mode-map
         ("C-M-q" . nil))
  :config
  (leaf elisp-slime-nav
    :ensure t
    :bind (:elisp-slime-nav-mode-map ("C-c C-d" . helpful-at-point))
    :hook emacs-lisp-mode-hook help-mode-hook)
  (leaf eldoc :blackout t :hook emacs-lisp-mode-hook ielm-mode-hook)
  (leaf flycheck-package :ensure t :defun flycheck-package-setup :config (flycheck-package-setup))
  (leaf ielm :bind (:ielm-map ("C-c C-d" . helpful-at-point)))
  (leaf macrostep :ensure t))

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

;;; Haskell

(leaf haskell-mode
  :ensure t
  :bind
  (:haskell-mode-map
   ("C-c C-b" . haskell-hoogle)
   ("C-c C-c" . haskell-session-change-target)
   ("C-c C-p" . haskell-command-insert-language-pragma)
   ("C-c C-s" . nil)
   ("M-i" . stylish-haskell-toggle)
   ([remap indent-whole-buffer] . haskell-mode-stylish-buffer))
  :config
  ;; もう使われてないようですが古いプロジェクトではローカル変数として追加されることが多いので許可しておく。
  (add-to-list 'safe-local-variable-values '(haskell-indent-spaces . 4))
  (add-to-list 'safe-local-variable-values '(haskell-process-use-ghci . t))
  ;; melpaに登録されている名前はhaskell-modeで、haskell.elがhaskell-mode.elを読み込むよく分からない状態です。
  ;; melpaに登録されている名前を優先することにします。
  (leaf haskell
    :blackout interactive-haskell-mode
    :init
    (defun haskell-interactive-repl-flycheck ()
      "左ウィンドウにコード画面を残し、右ウィンドウを上下に分割してREPLとFlycheckを開く。"
      (interactive)
      (delete-other-windows)
      (flycheck-list-errors)
      (haskell-process-load-file)
      (haskell-interactive-switch)
      (split-window-below)
      (other-window 1)
      (switch-to-buffer flycheck-error-list-buffer)
      (other-window 1))
    :bind
    (:interactive-haskell-mode-map
     ("C-c z"   . haskell-interactive-repl-flycheck)
     ("C-c C-b" . nil)
     ("C-c C-c" . nil)
     ("C-c C-r" . nil)
     ("C-c C-t" . nil)
     ("C-c TAB" . nil)
     ("M-." . nil)))
  (leaf haskell-customize
    :doc "haskell-stylish-on-saveがhaskell-customizeに属する。"
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
        "プロジェクトディレクトリにstylish-haskellの設定ファイルがある場合、
保存したときに自動的にstylish-haskellを適用する。"
        (if (locate-dominating-file default-directory ".stylish-haskell.yaml")
            (stylish-haskell-enable)
          (stylish-haskell-disable))))
    :hook (haskell-mode-hook . stylish-haskell-setup))
  (leaf haskell-hoogle
    :custom
    (haskell-hoogle-command . nil)
    (haskell-hoogle-url . "https://www.stackage.org/lts/hoogle?q=%s"))
  (leaf haskell-interactive-mode
    :after t
    :defvar haskell-interactive-mode-map
    :config (dvorak-set-key haskell-interactive-mode-map))
  (leaf haskell-cabal
    :defvar haskell-cabal-mode-map
    :config (dvorak-set-key-prog haskell-cabal-mode-map))
  (leaf lsp-haskell
    :ensure t
    :require t
    :hook
    (haskell-mode-hook . lsp)
    :custom
    ;; フォーマッターをfourmoluにする。fourmoluのデフォルト値も気に入らないがカスタマイズ出来るだけマシ。
    (lsp-haskell-formatting-provider . "fourmolu")
    ;; 補完時にスニペット展開(型が出てくるやつ)を行わないようにする。
    (lsp-haskell-completion-snippets-on . nil)
    ;; 関数補完からの自動importはcompanyから誤爆する可能性が高すぎるので無効化する。
    (lsp-haskell-plugin-ghcide-completions-config-auto-extend-on . nil)
    ;; lintが厳しいだけならともかく、StrictDataなどを有効化していても認識してくれないため無効化する。
    (lsp-haskell-plugin-stan-global-on . nil)
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
           ("C-c C-o" . lsp-haskell-execute-code-action-add-signature))))

(leaf shakespeare-mode :ensure t)

;;; Java

(leaf java-mode
  :config
  (leaf lsp-java
    :ensure t
    :require t
    :hook (java-mode-hook . lsp)))

(leaf groovy-mode :ensure t)

;;; Markdown

(leaf markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :custom
  (markdown-fontify-code-blocks-natively . t)
  (markdown-hide-urls . nil)
  :bind (:markdown-mode-map ("C-c k" . markdown-insert-kbd))
  :defvar markdown-mode-map markdown-code-lang-modes
  :config
  (dvorak-set-key-prog markdown-mode-map)
  (mapc
   (lambda (mode) (add-to-list 'markdown-code-lang-modes mode))
   '(("hs" . haskell-mode)
     ("html" . web-mode)
     ("ini" . conf-mode)
     ("js" . web-mode)
     ("jsx" . web-mode)
     ("md" . markdown-mode)
     ("ps1" . powershell-mode)
     ("py" . python-mode)
     ("rb" . ruby-mode)
     ("rs" . rustic-mode)
     ("sqlite3" . sql-mode)
     ("ts" . web-mode)
     ("tsx" . web-mode)
     ("zsh" . sh-mode)))
  (leaf lsp-marksman :ensure :require t :hook (markdown-mode-hook . lsp)))

;;; OCaml

(leaf tuareg
  :ensure t
  :mode ("\\.ml[iylp]?$" . tuareg-mode)
  :config
  (leaf merlin
    :ensure t
    :hook (tuareg-mode-hook . merlin-mode)
    :config
    (leaf merlin-company :ensure t :require t)
    (leaf merlin-eldoc :ensure t :hook (merlin-mode-hook . merlin-eldoc-setup)))
  (leaf ocamlformat
    :ensure t
    :custom (ocamlformat-enable . 'enable-outside-detected-project)
    :init
    (defun ocamlformat-setup ()
      (add-hook 'before-save-hook 'ocamlformat-before-save nil t))
    :hook (tuareg-mode-hook . ocamlformat-setup))
  (leaf utop :ensure t :hook (tuareg-mode-hook . utop-minor-mode)))

(leaf dune
  :ensure t
  :config (leaf dune-format :ensure t :hook (dune-mode-hook . dune-format-on-save-mode)))

;;; PowerShell

(leaf powershell
  :ensure t
  :init
  (defun powershell-setup ()
    (set-buffer-file-coding-system 'utf-8-with-signature-dos))
  :hook
  (powershell-mode-hook . powershell-setup)
  (powershell-mode-hook . lsp))

(leaf bat-mode
  :init
  (defun bat-setup ()
    (set-buffer-file-coding-system 'ascii-dos))
  :hook (bat-mode-hook . bat-setup))

;;; Prolog

(leaf prolog :custom (prolog-system . 'swi))

(leaf sweeprolog
  :doc "sweepを使う場合、SWI-Prologは手動でビルドする必要があります。
[SWI-Prolog -- Installation on Linux, *BSD (Unix)](https://www.swi-prolog.org/build/unix.html)"
  :ensure t
  :mode (("\\.plt?\\'" "\\.pro\\'" "\\.P\\'" "\\.prolog\\'") . language-detection-mode-switch)
  :defun sweeprolog-identifier-at-point
  :init
  (defun sweeprolog-describe-predicate-at-point ()
    "
現在のポイントにあるPrologの述語を説明します。

ポイント位置にPrologの識別子がある場合、その識別子に関連する述語の説明を表示します。
識別子が存在しない場合はエラーメッセージ「There is no term at point.」を表示します。

この関数は主に`sweeprolog-identifier-at-point`と、
`sweeprolog-describe-predicate`と連携して動作します。
`sweeprolog-identifier-at-point`は現在のポイントでの識別子を取得し、
`sweeprolog-describe-predicate`は識別子の述語を説明します。
"
    (interactive)
    (if-let ((symbol (sweeprolog-identifier-at-point)))
        (sweeprolog-describe-predicate symbol)
      (user-error "There is no term at point.")))
  (defun sweeprolog-setup ()
    ;; sweeprologがflymakeにしか対応していないためflycheckを無効化してflymakeを有効化します。
    (flycheck-mode -1)
    (flymake-mode 1))
  :hook (sweeprolog-mode-hook . sweeprolog-setup)
  :bind (:sweeprolog-mode-map
         ("C-M-;" . sweeprolog-document-predicate-at-point)
         ("C-M-m" . nil)
         ("C-c C-d" . sweeprolog-describe-predicate-at-point)
         ("C-c C-w" . sweeprolog-restart)
         ("C-c C-z" . sweeprolog-top-level)
         ("C-c RET" . sweeprolog-insert-term-dwim)
         ("C-x d" . sweeprolog-mark-predicate)
         ("M-h" . nil)
         ("M-n" . nil)
         ("M-p" . nil)))

;;; Python

(leaf python
  :custom
  (python-indent-guess-indent-offset-verbose . nil)
  (python-shell-prompt-detect-failure-warning . nil)
  :defvar python-shell-completion-native-disabled-interpreters python-shell-virtualenv-root
  :config
  (leaf elpy
    :ensure t
    :defvar elpy-modules
    :defun elpy-enable
    :init (elpy-enable)
    :custom
    (elpy-rpc-python-command . "python3")
    (elpy-formatter . 'black)
    :bind
    (:elpy-mode-map
     ([remap elpy-doc] . lsp-ui-doc-show)
     ([remap indent-whole-buffer] . elpy-black-fix-code))
    :config
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
  (leaf python-isort
    :ensure t
    :custom
    (python-isort-arguments . '("--stdout" "--atomic" "--profile" "black" "-"))
    :hook (python-mode-hook . python-isort-on-save-mode))
  (leaf poetry :ensure t :commands poetry-track-virtualenv)
  (leaf pipenv
    :ensure t
    :commands pyvenv-track-virtualenv
    :defun pipenv--force-wait pipenv-projectile-after-switch-extended pipenv-venv
    :custom (pipenv-projectile-after-switch-function . #'pipenv-projectile-after-switch-extended)
    :config (add-to-list 'python-shell-completion-native-disabled-interpreters "pipenv"))
  (leaf lsp-pyright
    :ensure t
    :require t
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
          (setq-local python-shell-interpreter-args "run python3")
          (setq-local lsp-pyright-venv-path python-shell-virtualenv-root))
        (lsp))
       (t
        (pyvenv-track-virtualenv)
        (when python-shell-virtualenv-root
          (setq-local pyvenv-activate (directory-file-name python-shell-virtualenv-root))
          (setq-local lsp-pyright-venv-path python-shell-virtualenv-root))
        (lsp))))
    :hook (python-mode-hook . lsp-pyright-setup)))

(leaf ein :ensure t)

;;; Raku

(leaf raku-mode
  :ensure t
  :custom (raku-indent-offset . 2)
  :config (leaf flycheck-raku :ensure t))

;;; Ruby

(leaf ruby-mode
  :custom (ruby-insert-encoding-magic-comment . nil)
  :hook (ruby-mode-hook . lsp)
  :defvar ruby-mode-map
  :config
  (dvorak-set-key-prog ruby-mode-map)
  (leaf inf-ruby :ensure t :hook (ruby-mode-hook . inf-ruby-minor-mode)))

;;; Rust

(leaf rustic
  :ensure t
  :mode "\\.rs$"
  :custom
  (lsp-rust-analyzer-cargo-watch-command . "clippy")
  (rustic-format-display-method . 'ignore) ; Rustfmtのメッセージをポップアップしない
  (rustic-format-trigger . 'on-save))

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

;;; Sh Shell

(leaf sh-script
  :custom (sh-basic-offset . 2)
  :config
  (leaf sh
    :mode "\\.zsh$"
    :defvar sh-shell
    :init
    (defun sh-setup ()
      "lspを起動する。
[bash-lsp/bash-language-server: A language server for Bash](https://github.com/bash-lsp/bash-language-server)
はzshに対応していない。"
      (when (member sh-shell '(sh bash)) (lsp)))
    :hook (sh-mode-hook . sh-setup)))

;;; Swift

(leaf swift-mode
  :ensure t
  :config
  (leaf lsp-sourcekit
    :ensure t
    :require t
    :when (eq system-type 'darwin)
    :hook (swift-mode-hook . lsp)
    :custom
    (lsp-sourcekit-executable
     . "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))
  (leaf swift-helpful
    :ensure t
    :when (eq system-type 'darwin)
    :bind
    (:swift-mode-map
     ([remap lsp-describe-thing-at-point] . swift-helpful)))
  (leaf company-sourcekit
    :ensure t
    :when (eq system-type 'darwin)
    :config (add-to-list 'company-backends 'company-sourcekit))
  (leaf reformatter
    :ensure t
    :init
    ;; swift-formatとSwiftFormatがそれぞれ全く違うプログラムとして存在している。
    (eval-and-compile
      (with-no-warnings
        (reformatter-define swift-format :program "swift-format"))
      (with-no-warnings
        (reformatter-define swiftformat :program "swiftformat"
          :args `("--config" ,(concat (locate-dominating-file default-directory ".swiftformat") "/.swiftformat")))))
    (defun swift-format-setup ()
      ;; 改行前自動インデントは無効化し、改行後自動インデントは有効化する。
      (setq-local electric-indent-mode nil)
      (define-key swift-mode-map [remap newline] 'newline-and-indent)
      ;; SwiftFormat向けの設定ファイルが存在すればSwiftFormatを使い、そうでなければswift-formatを使う。
      (if (locate-dominating-file default-directory ".swiftformat")
          (progn
            (swiftformat-on-save-mode)
            (define-key swift-mode-map [remap indent-whole-buffer] 'swiftformat-buffer))
        (progn
          (swift-format-on-save-mode)
          (define-key swift-mode-map [remap indent-whole-buffer] 'swift-format-buffer))))
    :hook (swift-mode-hook . swift-format-setup)))

;;; VB

(leaf visual-basic-mode
  :straight (visual-basic-mode :type git :host github :repo "emacsmirror/visual-basic-mode")
  :mode "\\.\\(?:frm\\|\\(?:ba\\|cl\\|vb\\)s\\)\\'"
  :custom
  (visual-basic-capitalize-keywords-p . nil) ; 文字列リテラルの内部の名前まで変更してしまうのでオフにします
  :bind (:visual-basic-mode-map ("C-i" . nil))
  :defvar visual-basic-mode-map
  :config
  (dvorak-set-key-prog visual-basic-mode-map)
  (leaf smartparens :config (sp-local-pair 'visual-basic-mode "'" "'" :actions nil)))

;;; Web

(leaf add-node-modules-path :ensure t :defun add-node-modules-path)

(leaf prettier-rc
  :ensure t
  :init
  (defun prettier-toggle-setup ()
    "prettierの有効無効キーバインドを使えるようにして、自動prettier適応を有効にします。"
    (interactive)
    (add-node-modules-path)
    ;; 全体フォーマットをEmacsではなくprettierが行うように
    (local-set-key [remap indent-whole-buffer] 'prettier-rc)
    ;; M-iでprettierの一時的無効化が出来るように
    (local-set-key (kbd "M-i") 'prettier-rc-mode)
    ;; prettierを有効化
    (prettier-rc-mode t)))

(leaf web-mode
  :ensure t
  :mode
  "\\.[agj]sp\\'"
  "\\.[cm]?[jt]sx?\\'"
  "\\.as[cp]x\\'"
  "\\.djhtml\\'"
  "\\.ejs\\'"
  "\\.erb\\'"
  "\\.html?\\'"
  "\\.mustache\\'"
  "\\.php\\'"
  "\\.phtml\\'"
  "\\.tpl\\'"
  "\\.vue\\'"
  ;; js-modeが指定されているインタプリタにおいてweb-modeが指定されるようにします。
  :interpreter
  `,(seq-filter 'stringp (seq-map (lambda (regex-mode) (pcase regex-mode (`(,regex . js-mode) regex))) interpreter-mode-alist))
  :custom
  (web-mode-enable-auto-indentation . nil)
  (web-mode-enable-auto-quoting . nil)
  (web-mode-enable-current-column-highlight . t)
  (web-mode-enable-current-element-highlight . t)
  :custom-face
  (web-mode-jsx-depth-1-face . '((t (:background "#073844"))))
  (web-mode-jsx-depth-2-face . '((t (:background "#083C49"))))
  (web-mode-jsx-depth-3-face . '((t (:background "#08404F"))))
  (web-mode-jsx-depth-4-face . '((t (:background "#094554"))))
  (web-mode-jsx-depth-5-face . '((t (:background "#0A4D5E"))))
  :init
  (defun web-mode-setup ()
    (setq-local lsp-enabled-clients '(ts-ls eslint))
    (lsp)
    (prettier-toggle-setup))
  :hook (web-mode-hook . web-mode-setup)
  :bind
  (:web-mode-map
   ([remap comment-indent-new-line] . web-mode-comment-indent-new-line)
   ("C-c C-f" . lsp-eslint-apply-all-fixes))
  :defvar web-mode-comment-formats
  :config
  ;; コメントを`/*'式から`//'形式にする。
  (add-to-list 'web-mode-comment-formats '("javascript" . "//"))
  (add-to-list 'web-mode-comment-formats '("jsx" . "//"))
  (leaf smartparens :config (sp-local-pair 'web-mode "<" ">" :actions nil)))

(leaf js :custom (js-indent-level . 2))

(leaf graphql-mode :ensure t :hook (graphql-mode-hook . prettier-toggle-setup))
(leaf json-mode    :ensure t :hook (json-mode-hook    . prettier-toggle-setup) (json-mode-local-vars-hook . lsp))
(leaf yaml-mode    :ensure t :hook (yaml-mode-hook    . prettier-toggle-setup) (yaml-mode-local-vars-hook . lsp))

(leaf prisma-mode
  :straight (prisma-mode :type git :host github :repo "pimeys/emacs-prisma-mode" :branch "main")
  :hook (prisma-mode-hook . lsp))

(leaf yarn-mode :ensure t)

(leaf css-mode
  :custom (css-indent-offset . 2)
  :hook (css-mode-hook . lsp) ((css-mode-hook scss-mode-hook) . prettier-toggle-setup))
(leaf less-css-mode :hook (less-css-mode-hook . prettier-toggle-setup))

(leaf nxml-mode
  :mode "\\.fxml\\'"
  :custom (nxml-slash-auto-complete-flag . t)
  :defvar nxml-mode-map
  :bind (:nxml-mode-map
         ("M-h" . nil)
         ("C-M-t" . nil)
         ("C-M-p" . nxml-backward-element))
  :config
  (dvorak-set-key-prog nxml-mode-map)
  (leaf smartparens :config (sp-local-pair 'nxml-mode "<" ">" :actions nil)))

;; 起動終わりの処理

(leaf gcmh
  :doc "アイドル状態かなどの判定からGCを調整してくれます。"
  :ensure t
  :blackout t
  :custom (gcmh-mode . t))

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
