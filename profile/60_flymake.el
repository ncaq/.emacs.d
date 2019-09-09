;; -*- lexical-binding: t -*-

(with-eval-after-load 'flymake
  (custom-set-variables
   '(flymake-error-bitmap nil)
   '(flymake-note-bitmap nil)
   '(flymake-warning-bitmap nil)
   )
  (set-face-underline 'flymake-error nil)
  (set-face-underline 'flymake-note nil)
  (set-face-underline 'flymake-warning nil)
  )
