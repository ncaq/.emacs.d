;; -*- lexical-binding: t -*-

;; 初期の初期から設定しておきたい
(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")  ; init.elに設定ファイルを書き込ませない
 ;; gcの起動条件を緩くしてメモリを犠牲にパフォーマンスを向上
 '(gc-cons-percentage (* gc-cons-percentage 5))
 '(gc-cons-threshold (* gc-cons-threshold 5))
 ;; 再帰回数の制限緩くしてフリーズの危険性を犠牲にエラー落ちを減らす
 '(max-lisp-eval-depth (* max-lisp-eval-depth 20))
 '(max-specpdl-size (* max-specpdl-size 20))
 )

;; set load-path
(mapc (lambda (path)
        (let ((default-directory path))
          (normal-top-level-add-subdirs-to-load-path)))
      (list (concat user-emacs-directory "module/")))

(eval-and-compile
  (prog1 "leaf init"
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

(custom-set-variables '(inhibit-startup-screen t)) ; スタートアップ画面を出さない

(defun kill-buffer-if-exist (BUFFER-OR-NAME)
  (when (get-buffer BUFFER-OR-NAME)
    (kill-buffer BUFFER-OR-NAME)))

(kill-buffer-if-exist "*Compile-Log*")
(kill-buffer-if-exist "*scratch*")

(leaf server
  :require t
  :config (unless (server-running-p)
            (server-start)))

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
  :after compile
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

(leaf info      :after info      :config (ncaq-set-key Info-mode-map))
(leaf prog-mode :after prog-mode :config (ncaq-set-key prog-mode-map))

(leaf comint    :after comint    :defvar comint-mode-map         :config (ncaq-set-key comint-mode-map))
(leaf diff-mode :after diff-mode :defvar diff-mode-map           :config (ncaq-set-key diff-mode-map))
(leaf doc-view  :after doc-view  :defvar doc-view-mode-map       :config (ncaq-set-key doc-view-mode-map))
(leaf help-mode :after help-mode :defvar help-mode-map           :config (ncaq-set-key help-mode-map))
(leaf make-mode :after make-mode :defvar makefile-mode-map       :config (ncaq-set-key makefile-mode-map))
(leaf man       :after man       :defvar Man-mode-map            :config (ncaq-set-key Man-mode-map))
(leaf pascal    :after pascal    :defvar pascal-mode-map         :config (ncaq-set-key pascal-mode-map))
(leaf prolog    :after prolog    :defvar prolog-mode-map         :config (ncaq-set-key prolog-mode-map))
(leaf rect      :after rect      :defvar rectangle-mark-mode-map :config (ncaq-set-key rectangle-mark-mode-map))
(leaf rg        :after rg        :defvar rg-mode-map             :config (ncaq-set-key rg-mode-map))

;; global-set-key

;; 何かしらを割り当てることで,C-iと別扱いになる
(global-set-key (kbd "<tab>") 'indent-for-tab-command)

(global-set-key (kbd "C-'") 'mc/mark-all-dwim)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-;") 'toggle-input-method)
(global-set-key (kbd "C-=") 'text-scale-reset)
(global-set-key (kbd "C-^") 'dired-jump-to-current)
(global-set-key (kbd "C-a") 'smart-move-beginning-of-line)
(global-set-key (kbd "C-b") 'backward-delete-char-untabify)
(global-set-key (kbd "C-i") 'indent-whole-buffer)
(global-set-key (kbd "C-j") 'helm-do-ag-project-root-or-default)
(global-set-key (kbd "C-o") 'helm-for-files)
(global-set-key (kbd "C-p") 'other-window-fallback-split)
(global-set-key (kbd "C-q") 'kill-this-buffer)
(global-set-key (kbd "C-u") 'kill-whole-line)
(global-set-key (kbd "C-w") 'kill-region-or-word-at-point)
(global-set-key (kbd "C-z") 'flycheck-list-errors)

(global-set-key (kbd "<C-iso-lefttab>") 'company-dabbrev)
(global-set-key (kbd "C-<tab>")         'company-complete)
(global-set-key (kbd "C-\\")            'quoted-insert)

(global-set-key (kbd "C-S-b") 'smart-delete-whitespace-backward)
(global-set-key (kbd "C-S-d") 'smart-delete-whitespace-forward)
(global-set-key (kbd "C-S-m") 'quoted-newline)

(global-set-key (kbd "M-'") 'mc/edit-lines)
(global-set-key (kbd "M-b") 'backward-kill-word)
(global-set-key (kbd "M-c") 'help-command)
(global-set-key (kbd "M-f") 'helm-occur)
(global-set-key (kbd "M-j") 'helm-do-ag-project-root-or-default-at-point)
(global-set-key (kbd "M-l") 'sort-dwim)
(global-set-key (kbd "M-m") 'newline-under)
(global-set-key (kbd "M-n") 'scroll-up-one)
(global-set-key (kbd "M-o") 'helm-multi-files)
(global-set-key (kbd "M-p") 'other-window-backward)
(global-set-key (kbd "M-q") 'delete-other-windows)
(global-set-key (kbd "M-r") 'revert-buffer-safe-confirm)
(global-set-key (kbd "M-t") 'scroll-down-one)
(global-set-key (kbd "M-u") 'copy-whole-line)
(global-set-key (kbd "M-w") 'kill-ring-save-region-or-word-at-point)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-z") 'flycheck-compile)

(global-set-key (kbd "C-M-;") 'align-space)
(global-set-key (kbd "C-M-b") 'backward-kill-sexp)
(global-set-key (kbd "C-M-d") 'kill-sexp)
(global-set-key (kbd "C-M-j") 'helm-do-ag)
(global-set-key (kbd "C-M-l") 'sort-lines-whole-buffer)
(global-set-key (kbd "C-M-m") 'newline-upper)
(global-set-key (kbd "C-M-o") 'ibuffer)
(global-set-key (kbd "C-M-p") 'split-window-dwim-and-other)
(global-set-key (kbd "C-M-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-M-w") 'copy-to-register-@)
(global-set-key (kbd "C-M-y") 'yank-register-@)

(global-set-key (kbd "C-M-S-q") 'kill-file-or-dired-buffers)

(global-set-key (kbd "C-c ;") 'align-regexp)
(global-set-key (kbd "C-c a") 'open-downloads)
(global-set-key (kbd "C-c c") 'quickrun)
(global-set-key (kbd "C-c e") 'open-ncaq-entry)
(global-set-key (kbd "C-c j") 'rg)
(global-set-key (kbd "C-c l") 'recentf-cleanup)
(global-set-key (kbd "C-c n") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c o") 'open-desktop)
(global-set-key (kbd "C-c p") 'tramp-cleanup-all-connections)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c u") 'open-document-current)

(global-set-key (kbd "C-x d") 'mark-defun)
(global-set-key (kbd "C-x g") 'insert-random-uuid)
(global-set-key (kbd "C-x p") 'mark-paragraph)
(global-set-key (kbd "C-x t") 'insert-iso-datetime)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "M-g b") 'magit-blame)
(global-set-key (kbd "M-g d") 'magit-diff)
(global-set-key (kbd "M-g f") 'magit-find-file)
(global-set-key (kbd "M-g g") 'magit-dispatch-popup)
(global-set-key (kbd "M-g l") 'magit-log-buffer-file)
(global-set-key (kbd "M-g s") 'magit-status)

(global-set-key (kbd "<help> w") 'helm-man-woman)

(global-set-key (kbd "C-x <RET> s") (lambda () (interactive) (revert-buffer-with-coding-system 'japanese-cp932-dos)))

(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

;; 見た目
;; 等幅になるようにRictyを設定
(set-face-attribute 'default nil :family "Ricty" :height 135)
(set-fontset-font t 'unicode (font-spec :name "Ricty") nil 'append)

;; シンタックスハイライトをグローバルで有効化
(global-font-lock-mode 1)

;; テーマを読み込む
(leaf solarized-theme
  :ensure t
  :config (load-theme 'solarized-dark t))

;; 以下の順番で読み込まないと正常に動かなかった
;; rainbow-delimiters -> rainbow-mode

;; 括弧の対応を色対応でわかりやすく
(leaf rainbow-delimiters
  :ensure t
  :hook ((prog-mode-hook web-mode-hook) . rainbow-delimiters-mode-enable)
  :config (set-face-foreground 'rainbow-delimiters-depth-1-face "#586e75")) ;文字列の色と被るため,変更

;; 色コードを可視化
(leaf rainbow-mode
  :ensure t
  :hook css-mode-hook emacs-lisp-mode-hook hamlet-mode-hook help-mode-hook lisp-mode-hook sass-mode-hook scss-mode-hook web-mode-hook)

;; カットペーストなど挿入削除時にハイライト
(leaf volatile-highlights
  :ensure t
  :config (volatile-highlights-mode t))

;; 置換の動きを可視化
(leaf anzu
  :ensure t
  :config (global-anzu-mode t))

;; History
(leaf recentf-ext
  :ensure t
  :require t)

(leaf recentf-remove-sudo-tramp-prefix
  :ensure t
  :config (recentf-remove-sudo-tramp-prefix-mode 1))

(custom-set-variables
 ;; バックアップ先をカレントディレクトリから変更
 '(backup-directory-alist `(("" . ,(concat user-emacs-directory "file-backup/"))))

 ;; 自動保存(クラッシュ時の対応)先をカレントディレクトリから変更
 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(tramp-auto-save-directory temporary-file-directory)

 '(create-lockfiles nil)                ; ロックファイルとしてシンボリックリンクを作らない.parcelが大変なことになるので.
 '(delete-old-versions t)               ; askだと削除時に一々聞いてくる
 '(kept-new-versions 50)                ; backupに新しいものをいくつ残すか
 '(kept-old-versions 0)                 ; backupに古いものをいくつ残すか
 '(make-backup-files t)                 ; バックアップファイルを作成する。
 '(version-control t)                   ; 複数バックアップ

 '(message-log-max 100000)

 '(savehist-mode t)
 '(savehist-minibuffer-history-variables
   (cons 'extended-command-history savehist-minibuffer-history-variables))

 '(desktop-save-mode t)
 '(desktop-globals-to-save nil)
 '(desktop-restore-frames nil)

 '(recentf-max-saved-items 2000)
 '(helm-ff-file-name-history-use-recentf t)
 '(recentf-auto-cleanup (* 15 60))
 '(recentf-exclude '("\\.elc$"
                     "\\.o$"
                     "~$"

                     "\\.file-backup/"
                     "\\.undo-tree/"

                     "EDITMSG"
                     "PATH"
                     "TAGS"
                     "autoloads"
                     ))
 )

(defun setq-buffer-backed-up-nil (&rest _) (interactive) (setq buffer-backed-up nil))
(advice-add 'save-buffer :before 'setq-buffer-backed-up-nil)

(leaf save-place-mode :config (save-place-mode 1))

;; toolkit
(menu-bar-mode 0)                       ; メニューバーを表示させない
(tool-bar-mode 0)                       ; ツールバーを表示させない
(toggle-frame-maximized)                ; 全画面化

(auto-image-file-mode 1)                ; 画像を表示

;; ((ファイル名 or バッファ名) モード一覧)
(setq frame-title-format
      '(:eval (list (or (buffer-file-name) (buffer-name)) " " mode-line-modes)))

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
         )))

;; バッファの名前にディレクトリ名を付けることでユニークになりやすくする
(leaf uniquify
  :require t
  :custom (uniquify-buffer-name-style . 'forward))

;; toolkit end

(leaf company
  :ensure t
  :require t
  :defvar company-search-map
  :custom ((company-dabbrev-code-other-buffers . 'all) (company-dabbrev-downcase . nil) (company-dabbrev-other-buffers . 'all))
  :bind (:company-active-map
         ("<backtab>" . company-select-previous)
         ("<tab>" . company-complete-common-or-cycle)
         ("C-b" . 'nil))
  :config
  (global-company-mode 1)
  (ncaq-set-key company-active-map)
  (dvorak-set-key company-search-map)
  (leaf company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode 1)
    )
  )

(defun dired-jump-to-current ()
  (interactive)
  (dired "."))

(defvar ls-option (concat "-Fhval" (when (string-prefix-p "gnu" (symbol-name system-type)) " --group-directories-first")))

(leaf dired
  :require t
  :custom ((dired-auto-revert-buffer . t) ; diredの自動再読込
           (dired-dwim-target . t)
           (dired-isearch-filenames . t)
           (dired-listing-switches . ls-option)
           (dired-recursive-copies . 'always)  ; 聞かずに再帰的コピー
           (dired-recursive-deletes . 'always) ; 聞かずに再帰的削除
           )
  :config
  (leaf wdired
    :require t
    :bind (:dired-mode-map
           ("C-o" . nil)
           ("C-p" . nil)
           ("M-o" . nil)
           ("C-^" . dired-up-directory)
           ("C-c C-p" . wdired-change-to-wdired-mode)
           )
    :config (ncaq-set-key dired-mode-map)
    )
  )

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

(defvar ibuffer-formats '((mark modified read-only " " (name 60 30) " " (size 6 -1) " " (mode 16 16) " " filename)
                          (mark " " (name 60 -1) " " filename)))

(leaf ibuffer
  :after ibuffer
  :defvar ibuffer-mode-map
  :custom (ibuffer-formats . ibuffer-formats)
  :config
  (define-key ibuffer-mode-map (kbd "M-g") 'nil)
  (ncaq-set-key ibuffer-mode-map)
  (define-key ibuffer-mode-map (kbd "C-o") 'nil)
  )

(leaf profiler
  :after profiler-report-mode-map
  :defvar profiler-report-mode-map profiler-report-cpu-line-format
  :config
  (ncaq-set-key profiler-report-mode-map)
  (setq profiler-report-cpu-line-format '((100 left) (24 right ((19 right) (5 right))))))

(leaf helm
  :ensure t
  :require t helm-config
  :bind (:helm-map ("C-M-b" . nil) ("C-b" . nil) ("C-h" . nil) ("M-b" . nil) ("M-s" . nil) ("<tab>" . helm-select-action))
  :config
  (leaf helm-buffers :bind (:helm-buffer-map ("C-s" . nil)))
  (leaf helm-files :bind (:helm-find-files-map ("C-s" . nil)))
  (leaf helm-types :bind (:helm-generic-files-map ("C-s" . nil)))
  (leaf helm-ls-git
    :ensure t
    :require t
    :custom ((helm-source-ls-git . (helm-ls-git-build-ls-git-source))
             (helm-source-ls-git-status . (helm-ls-git-build-git-status-source))))
  (helm-mode 1)
  (swap-set-key
   helm-map
   '(("C-t" . "C-p")
     ("C-s" . "C-f")))
  :custom ((helm-boring-buffer-regexp-list . (append '("\\*Flymake" "\\*tramp") helm-boring-buffer-regexp-list))
           (helm-buffer-max-len-mode . 25) ; モードを短縮する基準
           (helm-buffer-max-length . 50)   ; デフォルトはファイル名を短縮する区切りが20
           (helm-delete-minibuffer-contents-from-point . t) ; kill-line sim
           (helm-descbinds-mode . t)
           (helm-samewindow . t)        ; ウインドウ全体に表示
           (helm-for-files-preferred-list . '(helm-source-buffers-list
                                              helm-source-recentf
                                              helm-source-files-in-current-dir
                                              helm-source-ls-git-status
                                              helm-source-ls-git
                                              helm-source-file-cache
                                              helm-source-locate
                                              ))))

(leaf helm-ag
  :ensure t
  :require t
  :custom ((helm-ag-base-command . "rg --no-heading --smart-case")
           (helm-grep-ag-command . "rg --color=always --smart-case --no-heading --line-number %s %s %s"))
  :config (advice-add 'helm-ag--save-current-context :after 'xref-push-marker-stack))

(autoload 'helm-ag--project-root "helm-ag")
(defun helm-do-ag-project-root-or-default ()
  (interactive)
  (if (helm-ag--project-root)
      (helm-do-ag-project-root)
    (helm-do-ag)))

(defun helm-do-ag-project-root-or-default-at-point ()
  (interactive)
  (let ((helm-ag-insert-at-point 'symbol))
    (helm-do-ag-project-root-or-default)))

(leaf git-gutter
  :ensure t
  :custom (global-git-gutter-mode . t))

(leaf ggtags
  :ensure t
  :custom ((ggtags-enable-navigation-keys . nil)
           (ggtags-global-ignore-case . t)))

(defun gtags-dir? ()
  (locate-dominating-file default-directory "GTAGS"))

(defun ggtags-mode-when-gtags-dir ()
  (when (gtags-dir?)
    (ggtags-mode 1)))

(add-hook 'find-file-hook 'ggtags-mode-when-gtags-dir)

(leaf smart-jump
  :ensure t
  :custom (smart-jump-refs-key . "C-,")
  :config (smart-jump-setup-default-registers))

(leaf magit
  :ensure t
  :config
  (leaf magit-files
    :bind (:magit-file-mode-map ("C-x g" . nil)))
  (leaf magit-mode
    :after magit-mode
    :defvar magit-mode-map
    :config (swap-set-key magit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-commit
    :after git-commit
    :defvar git-commit-mode-map
    :config (swap-set-key git-commit-mode-map '(("p" . "t") ("M-p" . "M-t"))))
  (leaf git-rebase
    :after git-rebase
    :defvar git-rebase-mode-map
    :config (swap-set-key git-rebase-mode-map '(("p" . "t") ("M-p" . "M-t")))
    )
  )

(leaf mozc-im
  :ensure t
  :require t
  :custom ((default-input-method . "japanese-mozc-im") (mozc-candidate-style . 'echo-area))
  :config
  (set-face-background 'mozc-preedit-selected-face "#268bd2")
  (add-hook 'input-method-activate-hook 'cursor-color-toggle)
  (add-hook 'input-method-deactivate-hook 'cursor-color-direct)
  (add-hook 'window-configuration-change-hook 'cursor-color-toggle))

(defun cursor-color-toggle ()
  (if current-input-method
      (set-face-background 'cursor "#00629D")
    (set-face-background 'cursor "#839496")))

(defun cursor-color-direct ()
  (set-face-background 'cursor "#839496"))

(leaf auto-sudedit :ensure t :config (auto-sudoedit-mode 1))
(leaf editorconfig :ensure t :config (editorconfig-mode 1))
(leaf help-fns+ :ensure t :require t)
(leaf ncaq-emacs-utils :require t)
(leaf symbolword-mode :ensure t :require t)
(leaf which-key :ensure t :config (which-key-mode 1))

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
  (sp-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  )

;; based on https://github.com/Fuco1/smartparens/wiki/Permissions
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

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
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
  )

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
  (set-face-foreground 'whitespace-trailing "#332B28")
  )

(leaf flycheck
  :ensure t
  :custom ((global-flycheck-mode . t)
           (flycheck-display-errors-function . nil) ; Echoエリアにエラーを表示しない
           (flycheck-highlighting-mode . nil)       ; 下線があると_が見えなくなる
           (flycheck-indication-mode 'left-fringe))
  :bind (:flycheck-mode-map
         ([remap previous-error] . flycheck-previous-error)
         ([remap next-error] . flycheck-next-error)))

(leaf lsp-mode
  :ensure t
  :custom (lsp-prefer-flymake . nil)    ; flycheckを優先する
  :bind (:lsp-mode-map
         ("C-." . helm-lsp-workspace-symbol)
         ("C-c C-e" . lsp-workspace-restart)
         ("C-c C-i" . lsp-format-buffer)
         ("C-c C-n" . lsp-rename)
         ("C-c C-r" . lsp-execute-code-action)
         ("C-c C-t" . lsp-describe-thing-at-point))
  :hook
  css-mode-hook
  dockerfile-mode-hook
  go-mode-hook
  haskell-mode-hook
  java-mode-hook
  python-mode-hook
  ruby-mode-hook
  scala-mode-hook
  typescript-mode-hook
  )

(leaf lsp-ui-doc
  :ensure t
  :defun lsp-ui-doc--display lsp-ui-doc--extract lsp-request, lsp--text-document-position-params
  :custom (lsp-ui-doc-delay . 2)         ; 初期値の0.2はせわしなさすぎる
  :bind (:lsp-mode-map ("C-c C-d" . lsp-ui-doc-show-manual))
  :config
  ;; 普通はアイドル時に自動でしかポップアップしないものを手動のキーバウンドで出す
  (defun lsp-ui-doc-show-manual ()
    (interactive)
    (lsp-ui-doc--display
     (thing-at-point 'symbol t)
     (lsp-ui-doc--extract (gethash "contents" (lsp-request "textDocument/hover" (lsp--text-document-position-params)))))))

(leaf docker
  :ensure t
  :custom (docker-container-shell-file-name . "/bin/bash"))

(require 'generic-x)

(add-to-list 'auto-mode-alist '("\\.accept_keywords$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.keywords$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.license$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.mask$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.unmask$" . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.use$" . conf-space-mode))

(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))

(leaf csharp-mode :ensure t)
(leaf dockerfile-mode :ensure t)
(leaf go-mode :ensure t)
(leaf mediawiki :ensure t :mode "\\.wiki$")
(leaf ssh-config-mode :ensure t :mode "\\.ssh/config$" "sshd?_config$")

;;  cc
(defun set-hook-after-save-clang-format ()
  (add-hook 'after-save-hook 'clang-format-buffer t t))

(leaf cc-mode
  :after cc-mode
  :defvar c-mode-base-map c-mode-map c++-mode-map
  :config
  (add-hook 'c-mode-hook 'set-hook-after-save-clang-format)
  (add-hook 'c++-mode-hook 'set-hook-after-save-clang-format)

  (ncaq-set-key c-mode-base-map)
  (define-key c-mode-map [remap indent-whole-buffer] 'clang-format-buffer)
  (define-key c++-mode-map [remap indent-whole-buffer] 'clang-format-buffer)
  )

;; D
(leaf d-mode
  :ensure t
  :custom ((c-default-style . (cons '(d-mode . "java") c-default-style))
           (dfmt-flags . '("--max_line_length=80")))
  :bind (:d-mode-map
         ([remap indent-whole-buffer] . dfmt-region-or-buffer)
         ([remap save-buffer] . 'save-buffer-and-dfmt))
  :config
  (defun save-buffer-and-dfmt ()
    "セーブした後dfmt-bufferする.
dfmt-bufferを先にしたりbefore-save-hookを使ったりすると
保存がキャンセルされてflycheckの恩恵を受けられない
"
    (interactive)
    (when (buffer-modified-p)
      (save-buffer)
      (when (and (dfmt-buffer) (buffer-modified-p)) (save-buffer))))
  )

;; Emacs Lisp
(custom-set-variables
 ;; emacs-lisp-checkdocは設定ファイルには不向き
 '(flycheck-disabled-checkers (append '(emacs-lisp-checkdoc) flycheck-disabled-checkers))
 '(flycheck-emacs-lisp-load-path load-path)
 )

(define-key emacs-lisp-mode-map (kbd "C-M-q") 'nil)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'help-mode-hook 'elisp-slime-nav-mode)

(define-key read-expression-map (kbd "<tab>") 'completion-at-point)

(leaf elisp-slime-nav
  :ensure t
  :bind (:elisp-slime-nav-mode-map ("C-c C-d" . elisp-slime-nav-describe-elisp-thing-at-point))
  )

;; Haskell
(custom-set-variables '(haskell-stylish-on-save t))

(defun stylish-haskell-enable ()
  (interactive)
  (custom-set-variables '(haskell-stylish-on-save t)))

(defun stylish-haskell-disable ()
  (interactive)
  (custom-set-variables '(haskell-stylish-on-save nil)))

(leaf haskell-mode
  :ensure t
  :after haskell-mode
  :defvar flymake-allowed-file-name-masks
  :require lsp lsp-haskell
  :bind (:haskell-mode-map
         (("C-M-z" . haskell-repl-and-flycheck)
          ("C-c C-c" . haskell-session-change-target)
          ("C-c C-l" . haskell-process-load-file)
          ("C-c C-z" . haskell-interactive-switch)
          ([remap indent-whole-buffer] . haskell-mode-stylish-buffer)))
  :config
  (setq flymake-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks))
  (leaf haskell-interactive-mode
    :after haskell-interactive-mode
    :defvar haskell-interactive-mode-map
    :config (ncaq-set-key haskell-interactive-mode-map)
    )
  (leaf haskell-cabal
    :after haskell-cabal
    :defvar haskell-cabal-mode-map
    :config (ncaq-set-key haskell-cabal-mode-map)
    )
  )

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

(leaf hamlet-mode
  :ensure t
  :config (add-hook 'hamlet-mode-hook 'hamlet-mode-config)
  )

(defun hamlet-mode-config ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (electric-indent-local-mode -1)
  )

(leaf quickrun
  :ensure t
  :after quickrun
  :config
  (quickrun-add-command "haskell"
    '((:command . "stack runghc")
      (:description . "Run Haskell file with Stack runghc(GHC)"))
    :override t))

;; Java
(leaf lsp-java
  :ensure t
  :require t
  :after cc-mode
  )

;; Markdown
(cl-delete-if (lambda (element) (equal (cdr element) 'markdown-mode)) auto-mode-alist)
(leaf markdown-mode
  :ensure t
  :mode "\\.md\\'" "\\.markdown\\'"
  :custom ((markdown-code-lang-modes . (append '(("diff" . diff-mode)
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
                                                 ("zsh" . sh-mode))
                                               markdown-code-lang-modes))
           (markdown-fontify-code-blocks-natively . t)
           (markdown-hide-urls . nil))
  :after markdown-mode
  :defvar markdown-mode-map
  :config (ncaq-set-key markdown-mode-map))

;; Raku/Perl6
(leaf perl6-mode
  :ensure t
  :custom (perl6-indent-offset . 2)
  :config (leaf flycheck-perl6 :ensure t))

;; Ruby
(leaf ruby-mode
  :custom ((inf-ruby-default-implementation . "pry")
           (inf-ruby-eval-binding . "Pry.toplevel_binding")
           (ruby-insert-encoding-magic-comment . nil))
  :after ruby-mode
  :defvar ruby-mode-map
  :config (ncaq-set-key ruby-mode-map))

;; Rust
(leaf rustic
  :ensure t
  :mode "\\.rs$"
  :custom ((rustic-format-display-method . 'pop-to-buffer-without-switch) ; エラーポップアップにフォーカスを移さない
           (rustic-format-on-save . t))                                     ; 保存時にrustfmtを動かす
  )

;; 本当にwithout switchしているわけではなく前のウィンドウにフォーカスを戻すだけ
(defun pop-to-buffer-without-switch (buffer-or-name &optional action norecord)
  (pop-to-buffer buffer-or-name action norecord)
  (other-window -1))

;; rusticの場合のみlspではなくrustic特有のflycheckを使う
;; clippyが見えるようになるので
(defun flycheck-select-checker-rustic ()
  (flycheck-select-checker 'rustic-clippy))
(add-hook 'rustic-mode-hook 'flycheck-select-checker-rustic)

;; Scala
(defun scala-mode-setting ()
  (add-hook 'after-save-hook 'lsp-format-buffer nil t))

(leaf scala-mode
  :ensure t
  :config (add-hook 'scala-mode-hook 'scala-mode-setting))

;; Web
(defun prettier-js-mode-enable ()
  (interactive)
  (prettier-js-mode t))

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
        (add-hook 'after-save-hook 'eslint-fix nil t)))))

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

(leaf web-mode
  :ensure t
  :require t
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
  (add-hook 'web-mode-hook 'web-mode-setting)
  )

(leaf typescript-mode
  :ensure t
  :custom (typescript-indent-level . 2)
  :config
  (flycheck-add-mode 'javascript-eslint 'typescript-mode)
  (add-hook 'typescript-mode-hook 'flycheck-select-tslint-or-eslint)
  (add-hook 'typescript-mode-hook 'prettier-js-mode-enable)
  )

(add-hook 'css-mode-hook 'prettier-js-mode-enable)
(add-hook 'json-mode-hook 'prettier-js-mode-enable)
(add-hook 'less-css-mode-hook 'prettier-js-mode-enable)
(add-hook 'scss-mode-hook 'prettier-js-mode-enable)

(leaf yaml-mode
  :ensure t
  :config (add-hook 'yaml-mode-hook 'prettier-js-mode-enable))

(advice-add 'eslint-fix :after 'flycheck-buffer)

;; XML
(leaf nxml-mode
  :mode "\\.fxml\\'"
  :custom (nxml-slash-auto-complete-flag . t)
  :after nxml-mode
  :defvar nxml-mode-map
  :config
  (leaf smartparens :config (sp-local-pair '(nxml-mode) "<" ">" :actions :rem))
  (ncaq-set-key nxml-mode-map)
  (define-key nxml-mode-map (kbd "M-b") 'nil)
  (define-key nxml-mode-map (kbd "C-M-p") 'nil)
  (define-key nxml-mode-map (kbd "C-M-t") 'nxml-backward-element)
  )

(custom-set-variables
 ;; Manページを現在のウィンドウで表示
 '(Man-notify-method 'bully)
 ;; 括弧移動無効
 '(blink-matching-paren nil)
 ;; ごみ箱を有効
 '(delete-by-moving-to-trash t)
 ;; diffをunifitedモードで
 '(diff-switches "-u")
 ;; 一部のコマンドを有効にする
 '(disabled-command-function nil)
 ;; ediffでウィンドウを横分割
 '(ediff-split-window-function 'split-window-horizontally)
 ;; ediffにframeを生成させない
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 ;; 自動折り返しを実質無効化
 '(fill-column 10000)
 ;; 自動再読込
 '(global-auto-revert-mode 1)
 ;; google翻訳のソースを英語に
 '(google-translate-default-source-language "en")
 ;; google翻訳の対象を日本語に
 '(google-translate-default-target-language "ja")
 ;; dotファイルで自動セミコロン挿入しない
 '(graphviz-dot-auto-indent-on-semi nil)
 ;; imaximaの全体を大きくする
 '(imaxima-scale-factor 10.0)
 ;; インデントをスペースで行う
 '(indent-tabs-mode nil)
 ;; 大文字と小文字を区別しない バッファ名
 '(read-buffer-completion-ignore-case t)
 ;; 大文字と小文字を区別しない ファイル名
 '(read-file-name-completion-ignore-case t)
 ;; ファイルの最後に改行
 '(require-final-newline t)
 ;; schemeの処理系はgauche
 '(scheme-program-name "gosh")
 ;; 最下段までスクロールしてもカーソルを中心に戻さない
 '(scroll-step 1)
 ;; skypeのid
 '(skype--my-user-handle "ncaq__")
 ;; 常にシンボリックリンクをたどる
 '(vc-follow-symlinks t)
 ;; インデント幅はデフォルト2
 '(tab-width 2)
 ;; 警告をエラーレベルでないと表示しない
 '(warning-minimum-level :error)
 ;; クリップボードをX11と共有
 '(x-select-enable-clipboard t)
 )

;;スクリプトに実行権限付加
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

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

(require 's)
(defun insert-random-uuid ()
  (interactive)
  (insert (s-trim (shell-command-to-string "uuidgen"))))
