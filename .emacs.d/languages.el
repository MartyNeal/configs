(setq
  c-mode-hook '(lambda () (font-lock-mode 1) (font-lock-add-keywords nil '(("\\<\\(\\sw+\\) ?(" 1 font-lock-function-name-face)) t))
  c++-mode-hook '(lambda () (font-lock-mode 1) (font-lock-add-keywords nil '(("\\<\\(\\sw+\\) ?(" 1 font-lock-function-name-face)) t))
  makefile-mode-hook '(lambda () (font-lock-mode 1))
  shell-mode-hook '(lambda () (font-lock-mode 1))
  dired-mode-hook '(lambda () (font-lock-mode 1))
  rmail-mode-hook '(lambda () (font-lock-mode 1))
  compilation-mode-hook '(lambda () (font-lock-mode 1))
  dired-load-hook '(lambda () (load "dired-x") (define-key dired-mode-map "&" 'dired-do-shell-command-in-background))
  lilypond-mode-hook '(lambda () (font-lock-mode 1)))

(setq auto-mode-alist 
 (cons '("\\.c$" . c-mode)
 (cons '("\\.h$" . c-mode)
 (cons '("\\.cpp$" . c++-mode)
 (cons '("\\.cxx$" . c++-mode)
 (cons '("\\.hxx$" . c++-mode)
 (cons '("\\.java$" . java-mode)
 (cons '("\\.pl$" . perl-mode)
 (cons '("\\.pm$" . perl-mode)
 (cons '("\\.scm$" . scheme-mode)
 (cons '("\\.rkt$" . scheme-mode)
 (cons '("\\.txt$" . text-mode) auto-mode-alist))))))))))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t)))

(load "~/.emacs.d/c.el")
(load "~/.emacs.d/racket.el")
(load "~/.emacs.d/ruby.el")
