(require 'cc-mode)

(defvar gtags-suggested-key-mapping)
(defun ncaq-c++-mode-set ()
  (c-set-style "bsd");http://www.02.246.ne.jp/~torutk/cxx/emacs/indentation.html
  (subword-mode t)
  (local-set-key (kbd "C-i") 'code-format-c);括弧も揃えるコードフォーマット;;gnu globalを自動的に有効にする
  (define-key c++-mode-map (kbd "C-x C-e") 'flymake-display-err-menu-for-current-line)
  )

(add-hook 'c-mode-common-hook 'ncaq-c++-mode-set)
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode));*.hをc++モードで開く

;;C++11向け
(add-hook 'c++-mode-hook
	  '(lambda()
	     ;; In theory, we could place some regexes into `c-mode-common-hook'. But note that their
	     ;; evaluation order matters.
	     (font-lock-add-keywords
	      nil '(;; complete some fundamental keywords
		    ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
		    ;; add the new C++11 keywords
		    ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
		    ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
		    ;; PREPROCESSOR_CONSTANT
		    ("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
		    ;; hexadecimal numbers
		    ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
		    ;; integer/float/scientific numbers
		    ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
		    ;; user-defined types (customizable)
		    ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(type\\|ptr\\)\\>" . font-lock-type-face)
		    ;; some explicit typenames (customizable)
		    ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
		    ))
	     ) t)
