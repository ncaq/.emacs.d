;; -*- lexical-binding: t -*-

(custom-set-variables '(imaxima-latex-preamble "\\usepackage{concrete} \\setlength{\\mathindent}{10em}"))

(defun imaxima-latex ()
  "Convert Maxima buffer to LaTeX.
This command does not work in XEmacs."
  (interactive)
  (let (pos2 label (pos (make-marker))
             (buf (generate-new-buffer "*imaxima-latex*"))
             (oldbuf (current-buffer)))
    (set-buffer buf)
    (insert-buffer oldbuf)
    ;;     ;; Remove copyright notice
    ;;     (goto-char (point-min))
    ;;     (search-forward "(%i1)" nil t 2)
    ;;     (search-backward "(%i1)" nil t)
    ;;     (delete-region (point-min) (point))
    ;;     (goto-char (point-min))
    (insert "\\documentclass[leqno,fleqn]{article}
\\usepackage{verbatim}
\\usepackage[cmbase]{flexisym}
\\usepackage{color}
\\usepackage{breqn}
\\setkeys{breqn}{compact}

\\setlength{\\textwidth}{180mm}
\\setlength{\\oddsidemargin}{15mm}
\\addtolength{\\oddsidemargin}{-1in}
\\setlength{\\evensidemargin}{15mm}
\\addtolength{\\evensidemargin}{-1in}

\\newcommand{\\ifrac}[2]{\\frac{#1}{#2}}
\\newcommand{\\ifracd}[2]{\\frac{#1}{#2}}
\\newcommand{\\ifracn}[2]{\\frac{#1}{#2}}
\\newcommand{\\isubscript}[2]{{#1}_{#2}}
\\newcommand{\\iexpt}[2]{{#1}^{#2}}
\\newcommand{\\isqrt}[1]{\\sqrt{#1}}
\\begin{document}\n")
    ;;     (while (and (not (eobp))
    ;;          (setq pos (next-single-property-change (point) 'display)))
    ;;       (goto-char pos)
    ;;       (insert "\\end{verbatim}\n\n")
    ;;       (setq pos (copy-marker (next-single-property-change (point) 'display)))
    ;;       (remove-text-properties (point) pos '(display nil))
    ;;       (setq pos2 (point))
    ;;       (re-search-forward "(\\([^)]*\\))")
    ;;       (setq label (match-string 1))
    ;;       (delete-region pos2 (point))
    ;;       (insert (format "\\begin{dmath}[number={%s}]\n" label))
    ;;       (goto-char pos)
    ;;       (insert "\\end{dmath}\n\n\\begin{verbatim}"))
    ;;     (goto-char (point-max))
    ;;     (insert "\n\\end{verbatim}\n\\end{document}")
    (while (not (eobp))
      (let* ((region-start (copy-marker (point)))
             (region-end (copy-marker (next-single-property-change (point) 'display nil (point-max))))
             (text-prop (get-text-property region-start 'display)))
        (if text-prop
            (progn
              (goto-char region-start)
              (remove-text-properties region-start region-end '(display nil))
              (goto-char region-end)
              (goto-char region-start)
              (re-search-forward "(\\([^)]*\\))")
              (setq label (match-string 1))
              (delete-region region-start (point))
              (goto-char region-start)
              (insert (format "\\begin{dmath}[number={%s}]\n" label))
              (goto-char region-end)
              (insert "\\end{dmath}\n\n"))
          (progn
            (goto-char region-start)
            (insert "\\begin{verbatim}")
            (goto-char region-end)
            (insert "\\end{verbatim}\n\n")))))
    (insert "\n\\end{document}")
    (switch-to-buffer-other-window buf)
    (latex-mode)))

(defun imaxima-dump-tex ()
  "Dump a TeX format file preloaded with the required packages."
  (with-temp-file (expand-file-name "mylatex.ltx" imaxima-tmp-subdir)
    (insert imaxima-mylatex))
  (with-temp-file (expand-file-name "format.tex" imaxima-tmp-subdir)
    (insert
     ;;"\\batchmode\n"
     (format "\\documentclass[%dpt,leqno,fleqn]{article}\n" imaxima-pt-size)
     imaxima-latex-preamble
     "\\usepackage{color}\n"
     "\\usepackage{exscale}\n"
     "\\usepackage[cmbase]{flexisym}\n"
     "\\usepackage{breqn}\n"
     "\\setkeys{breqn}{compact}\n"
     "\\setlength{\\textheight}{200cm}\n"
     ;; define \boxed from amsmath.sty
     "\\makeatletter
      \\providecommand\\boxed{}
      \\providecommand\\operatorname{}
      \\renewcommand{\\boxed}[1]{\\fbox{\\m@th$\\displaystyle#1$}}
      \\renewcommand{\\operatorname}[1]{%
      \\mathop{\\relax\\kern\\z@\\operator@font{#1}}}
      \\makeatother
      \\newcommand{\\ifrac}[2]{\\frac{#1}{#2}}
      \\newcommand{\\ifracd}[2]{\\frac{#1}{#2}}
      \\newcommand{\\ifracn}[2]{\\frac{#1}{#2}}
      \\newcommand{\\isubscript}[2]{{#1}_{#2}}
      \\newcommand{\\iexpt}[2]{{#1}^{#2}}
      \\newcommand{\\isqrt}[1]{\\sqrt{#1}}\n
      \\nofiles
      \\begin{document}
      \\end{document}"))
  (imaxima-with-temp-dir
   imaxima-tmp-subdir
   (apply 'call-process imaxima-tex-program nil nil nil
          (list imaxima-initex-option "&latex" "mylatex.ltx" "format"))))

(defun imaxima-tex-to-dvi (str label filename &optional linear)
  "Run LaTeX on STR.
Argument LABEL is used as equation label.  FILENAME is used for
temporary files.  Use linearized form if LINEAR is non-nil."
  (with-temp-file filename
    (insert
     ;;"\\batchmode\n"
     (format "\\documentclass[%dpt,leqno,fleqn]{article}\n" imaxima-pt-size)
     "\n% mylatex\n"
     (format "\\setlength{\\textwidth}{%dmm}\n"
             (round (/ (imaxima-get-window-width)
                       imaxima-scale-factor)))
     (if linear
         (concat
          ;; braces in both denominator and numerator
          "\\renewcommand{\\ifrac}[2]{\\left(#1\\right)/\\left(#2\\right)}"
          ;; only braces denominator
          "\\renewcommand{\\ifracd}[2]{#1/\\left(#2\\right)}"
          ;; only braces in numerator
          "\\renewcommand{\\ifracn}[2]{\\left(#1\\right)/#2}"
          "\\renewcommand{\\isubscript}[2]{\\mathrm{subscript}\\left(#1,#2\\right)}"
          "\\renewcommand{\\iexpt}[2]{\\mathrm{expt}\\left(#1,#2\\right)}"
          "\\renewcommand{\\isqrt}[1]{\\left(#1\\right)^{1/2}}\n")
       "")
     "\\begin{document}\n"
     (apply 'format "\\pagecolor[rgb]{%f,%f,%f}"
            (imaxima-color-to-rgb (imaxima-get-bg-color)))
     "\\pagestyle{empty}\n"
     (format "\\begin{%s}\n" imaxima-fnt-size)
     (apply 'format "\\color[rgb]{%f,%f,%f}"
            (imaxima-color-to-rgb imaxima-label-color))
     "\\tt"
     (if label
         (concat
          (format "\\begin{dmath}[number={%s}]\n" label)
          (apply 'format "\\color[rgb]{%f,%f,%f}"
                 (imaxima-color-to-rgb imaxima-equation-color))
          str (format "\\end{dmath}\n"))
       (concat
        (apply 'format "\\color[rgb]{%f,%f,%f}"
               (imaxima-color-to-rgb imaxima-equation-color))
        "\\begin{math} \\displaystyle " str (format " \\end{math}\n")))
     (format "\\end{%s}\n" imaxima-fnt-size)
     "\\end{document}"))
  (imaxima-with-temp-dir imaxima-tmp-subdir
                         (apply 'call-process imaxima-tex-program nil nil nil
                                (list "&mylatex" filename))))
