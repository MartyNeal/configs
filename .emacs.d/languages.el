(load "~/.emacs.d/c.el")
(load "~/.emacs.d/csharp-mode.el")
(load "~/.emacs.d/racket.el")
(load "~/.emacs.d/scala.el")

(setq auto-mode-alist 
 (cons '("\\.rkt$" . scheme-mode)
 (cons '("\\.groovy$" . groovy-mode) auto-mode-alist)))

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
