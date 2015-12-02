;;; everything-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "everything" "everything.el" (22075 45760 641957
;;;;;;  500000))
;;; Generated autoloads from everything.el

(defalias 'everything 'everything-find-file)

(autoload 'everything-find-file "everything" "\
Prompt for a search string, let the user choose one of the returned files and
open it.

\(fn)" t nil)

(autoload 'everything-find-prompt "everything" "\
Prompt for a query and return the chosen filename.
If the current major mode is dired or (e)shell-mode limit the search to
the current directory and its sub-directories.

\(fn)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; everything-autoloads.el ends here
