(package-initialize)

(message "cyg home init.el")
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(set-register ?0 '(file . "~/.emacs.d/init.el"))
(set-register ?1 '(file . "~/notes.org"))
(set-register ?2 '(file . "~/todo.org"))
(set-register ?3 '(file . "~/.bashrc"))
(set-register ?9 '(file . "~/.emacs.d/init.org"))

(setq user-full-name "Marty Neal"
      user-mail-address "marty.neal@interprose.com"
      twitter "@MartySNeal")

(let ((default-directory (concat user-emacs-directory (convert-standard-filename "site-lisp/"))))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path (concat user-emacs-directory (convert-standard-filename "snippets/")))
(add-to-list 'exec-path "C:/cygwin/bin")

(unless (package-installed-p 'use-package)
;    (defvar package-contents-refreshed)
;    (unless (boundp package-contents-refreshed)
      (package-refresh-contents)
;      (setq package-contents-refreshed t))
    (package-install 'use-package))
  (eval-when-compile (require 'use-package))
  (setq use-package-always-ensure t)

(setq inhibit-startup-screen t
      initial-scratch-message nil
      disabled-command-function nil
      visible-bell t)

;(set-fringe-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)

(use-package zenburn-theme
  :config 
  (load-theme 'zenburn t)
  ;(add-to-list 'default-frame-alist '(font . "Hasklig-11"))
  ;(set-frame-font "Hasklig-11" nil t)
  ;(set-frame-font "Consolas-11" nil t)
  ;(set-frame-font "Monoid-11" nil t) 
  ;(set-frame-font "System" nil t) 
  ;(set-frame-font "Firacode-11" nil t)
)

;(scroll-bar-mode 0)
(setq hscroll-margin 1
      scroll-conservatively 1
      scroll-preserve-screen-position t)

(setq mouse-yank-at-point t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "xdg-open")

(set-default 'truncate-lines t)
(set-default 'tab-width 4)
(set-default 'indent-tabs-mode nil)
(setq require-final-newline t)

(setq frame-title-format '("%f" (dired-directory dired-directory "%b")))
(column-number-mode)
(display-time-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq tramp-default-method "ssh")
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(setq proced-auto-update-interval 1)

(global-prettify-symbols-mode)
(global-font-lock-mode)
(global-hi-lock-mode)
(show-paren-mode)

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.office365.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-user "nealm@Webtrends.com"
      smtpmail-smtp-service 587)

(setq
  backup-by-copying t                             ; don't clobber symlinks
  backup-directory-alist '(("." . "~/.backups"))    ; don't litter my fs tree
  auto-save-file-name-transforms '((".*" "~/.backups" t))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)                              ; use versioned backups

(defun isearch-exit-other-end (rbeg rend)
    "Exit isearch, but at the other end of the search string."
    (interactive "r")
    (isearch-exit)
    (goto-char isearch-other-end))

(bind-keys*
  ("<f1>" . man)
  ("<f5>" . revert-buffer)
  ("C-x f" . find-file)
  ("C-x M-SPC" . delete-blank-lines)
  ("<C-return>" . (lambda () (interactive) (text-scale-increase 1)))
  ("<C-wheel-up>" . (lambda () (interactive) (text-scale-increase 1)))
  ("<C-wheel-down>" . (lambda () (interactive) (text-scale-decrease 1)))
  ([M-up] . (lambda () (interactive) (transpose-lines 1) (forward-line -2)))
  ([M-down] . (lambda () (interactive) (forward-line 1) (transpose-lines 1) (forward-line -1)))
  ("C-x w w" . (lambda () (interactive)(highlight-regexp (thing-at-point 'symbol))))
  ("M-g" . goto-line)
  ("M-Q" . (lambda () (interactive) (let ((fill-column (point-max))) (fill-paragraph))))
  ("C-c j" . (lambda () (interactive)
    (shell-command-on-region (mark) (point) "jq ." (buffer-name) t)
    (replace-string "
" "" nil (mark) (point)))))
(define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)

(use-package smartrep
  :config
  (setq smartrep-mode-line-active-bg nil)
  (smartrep-define-key global-map "C-x"
    '(("{" . shrink-window-horizontally)
      ("}" . enlarge-window-horizontally)))
  (smartrep-define-key global-map "C-x" '(("o" . other-window)))
  (smartrep-define-key global-map "C-x" '(("k" . (kill-buffer (current-buffer))))))

(use-package org
    :preface
  (defun my-org-clocktable-notodo (ipos tables params)
    "Removes TODO and DONE from headlines in org clocktables"
    (cl-loop for tbl in tables
             for entries = (nth 2 tbl)
             do (cl-loop for entry in entries
                         for headline = (nth 1 entry)
                         do (setq headline (replace-regexp-in-string "TODO \\|DONE " "" headline))
                         do (setcar (nthcdr 1 entry) headline)))
    (org-clocktable-write-default ipos tables params))

    :mode (("\\.org$" . org-mode))
    :config
    (setq org-agenda-files '(
      "~/notes.org" 
      "~/todo.org"))
    (setq org-pretty-entities t)

    ;; emacs can render things like *bold*, _italic_ and ~preformatted~
    ;; code and then hide the markers
    (setq org-hide-emphasis-markers t)
    (setq org-use-speed-commands t)
    (add-hook 'org-mode-hook (lambda ()
      (push '("#+BEGIN_SRC" . ?✎) prettify-symbols-alist)
      (push '("#+END_SRC" . ?✎) prettify-symbols-alist)
      (global-prettify-symbols-mode)))
    (use-package htmlize)
    (use-package org-bullets
      :config
      (setq org-bullets-bullet-list (list "●" "○" "►" "•"))
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))
    (use-package ox-reveal)
    (use-package org-journal
      :bind ("C-c C-j" . org-journal-new-entry))
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (redis . t)
       (shell . t)
      ))
    (set-face-attribute 'org-level-1 nil :height 1.3 :weight 'bold)
    (set-face-attribute 'org-level-2 nil :height 1.2)
    (set-face-attribute 'org-level-3 nil :height 1.1)
    (set-face-attribute 'org-todo nil :weight 'bold :box t)
    (setq jiralib-url "https://interprosecorp.atlassian.net/")
    (org-add-link-type "jira" (lambda (key) (org-open-link-from-string (concat jiralib-url "/browse/" key))))
)

(use-package ob-redis
  :preface
  (defun org-babel-execute:redis (body params)
    "org-babel redis hook."
    (let* ((db (or (cdr (assoc :db params)) ob-redis:default-db))
           (cmd (mapconcat 'identity (list "redis-cli -h" db) " ")))
      (replace-regexp-in-string "
" "" (org-babel-eval cmd body)))))

(use-package helm
        :init
        (use-package projectile)
        (use-package helm-projectile)
        :bind (
          ("C-x C-f" . helm-mini)
          ("M-x" . helm-M-x)
          :map helm-map
          ([tab] . helm-execute-persistent-action)
          ("C-z" . helm-select-action))
        :config
        (setq helm-move-to-line-cycle-in-source t
              helm-locate-command "locate %s -A %s"
              helm-mini-default-sources '(helm-source-buffers-list 
                                          helm-source-recentf    
                                          helm-source-files-in-current-dir 
                                          helm-source-file-cache
                                          helm-source-projectile-files-list
                                          helm-source-locate))
        (helm-mode)
        (set-face-attribute 'helm-selection nil :box t)
        (add-to-list 'helm-completing-read-handlers-alist
                     '(execute-extended-command . nil)))

(use-package persistent-soft) ; make unicode-fonts use a cache which speeds things up
(use-package unicode-fonts
  :init
  (prefer-coding-system 'utf-8)
  (set-language-environment "UTF-8")
  (set-default-coding-systems 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  :config 
  (unicode-fonts-setup))

(use-package fill-column-indicator
  :config 
  (setq fci-rule-column 120)
  (setq fill-column 80))

(use-package powerline
    :config
    (setq powerline-default-separator 'contour)
    (setq-default mode-line-format '("%e"
      (:eval
       (let* ((active (powerline-selected-window-active))
              (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
              (mode-line (if active 'mode-line 'mode-line-inactive))
              (face1 (if active 'powerline-active1 'powerline-inactive1))
              (separator (intern (format "powerline-%s-%s"
                                         (powerline-current-separator)
                                         (car powerline-default-separator-dir))))
                    (lhs (list ; left hand side
                          (powerline-raw "%*" face1 'l) ;modified/readonly
                          (funcall separator face1 mode-line)
                          (powerline-raw "%b" mode-line-buffer-id 'l) ;buffer name
                          (funcall separator mode-line face1)
                          (powerline-raw "%n" face1 'l) ;major mode
                          (powerline-major-mode face1 'l)))
                    (rhs (list ; right hand side
;                          (powerline-minor-modes face1 'r) ;minor modes
                          (funcall separator face1 mode-line)
                          (powerline-raw global-mode-string mode-line 'r) ;rest
                          (powerline-raw "L%4l:C%3c" mode-line 'r) ;line and column
                          (funcall separator mode-line face1)
                          (powerline-raw "%I %7p" face1 'r)))) ;buffersize and percentage from top
               (concat
                (powerline-render lhs)
                (powerline-fill face1 (powerline-width rhs))
                (powerline-render rhs)))))))

(use-package powerline
  :config
  (setq powerline-default-separator 'contour)
  (setq-default mode-line-format '("%e"
    (:eval
     (let* ((active (powerline-selected-window-active))
            (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
            (mode-line (if active 'mode-line 'mode-line-inactive))
            (face1 (if active 'powerline-active1 'powerline-inactive1))
            (separator (intern (format "powerline-%s-%s"
                                       (powerline-current-separator)
                                       (car powerline-default-separator-dir))))
                  (lhs (list ; left hand side
                        (powerline-raw "%* %n" face1 'l) ;modified/readonly and major mode
                        (powerline-major-mode face1 'l)
                        (powerline-raw " " face1 'r)))
                  (center (list

                        (powerline-raw "%b" mode-line-buffer-id 'l))) ;buffer name
                  (rhs (list ; right hand side
                        (funcall separator mode-line face1)
                        (powerline-raw " " face1 'r) ;line and column
                        (powerline-raw global-mode-string face1 'r) ;rest
                        (powerline-raw "L%4l:C%3c" face1 'r) ;line and column
                        (funcall separator face1 mode-line)
                        (powerline-raw " %I %7p" mode-line 'r)))) ;buffersize and percentage from top
               (concat 
                (powerline-render lhs)
			    (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                (powerline-render (list (funcall separator face1 mode-line)))
			    (powerline-fill-center mode-line (powerline-width center))
			    (powerline-render center)
			    (powerline-fill mode-line (powerline-width rhs))
			    (powerline-render rhs)))))))

(use-package chess
  :preface
  (defun chess-scid ()
    (interactive)
    (let ((file (make-temp-file "emacs-chess-game-" nil ".pgn"))
          (game chess-module-game))
      (with-temp-buffer
        (chess-game-to-pgn game)
        (write-file file))
      (thread-last file
        (replace-regexp-in-string "/cygdrive/c/" "C:\\\\")
        (replace-regexp-in-string "/" "\\\\")
        (call-process "/cygdrive/c/Program Files/Scid-4.4/bin/scid.exe" nil 0 nil))))
  (defun chess-fics ()
    "Sets the username and password on login"
    (interactive)
    (require 'passwords)
    (defvar fics-password)
    (chess-ics "freechess.org" 5000 "cheeseheadtothe" fics-password))
  :commands (list chess chess-fics)
  :bind (:map chess-display-mode-map ("C-c C-s" . chess-scid))
  :config
  (setq
   chess-default-engine '(chess-stockfish chess-phalanx)
   chess-display-highlight-legal nil
   chess-images-default-size 64
   chess-stockfish-path "/cygdrive/c/Program Files/Scid-4.4/bin/engines/stockfish.exe")
  (load "~/.emacs.d/elpa/chess-2.0.4/chess-pgn.elc")
  (advice-add 'chess :after
              (lambda (&rest r)
                (set-frame-size (selected-frame) 67 35)
                (scroll-bar-mode 0))))

(use-package highlight-tail
 :defer 3
 :config
 (setq highlight-tail-colors '(
   ("grey32" . 0)
   ("grey24" . 18)
  ))
  (highlight-tail-mode))

(use-package rotate
  :config
  (smartrep-define-key global-map "C-|"
  '(("w" . rotate-window)
    ("l" . rotate-layout))))

(use-package undo-tree
:config (global-undo-tree-mode))

(use-package auto-complete
  :defer 10
  :config (ac-config-default))

(use-package yasnippet
   :defer 20
   :config 
   (yas-global-mode)
   (setq yas-prompt-functions '(yas-completing-prompt)))

(use-package anaphora)

(use-package dash)
(use-package dash-functional)

(use-package multiple-cursors)

(use-package chef-mode
  :preface
    (defun keff ()
      (interactive)
      (message (concat "knife environment from file " (buffer-name)))
      (set-process-filter
        (start-process "keff" "*knife results*" "knife" "environment" "from" "file" (buffer-name))
        (lambda (_ output) (message output))))
  :mode (("chef\\-repo/environments/.*\\.json\\'" . chef-mode))
  :load-path "c:/opscode/chef/embedded/bin"
  :bind (:map chef-mode-map
    ("C-c C-c" . keff)))

(use-package expand-region
  :bind ("C-M-w" . er/expand-region)) ; despite Magnar's advice ;-)

(use-package epoch-view
    :load-path "site-lisp/"
    :config
    (setq epoch-view-time-zone "UTC0")
    (setq epoch-view-time-format "%FT%T %Z")
)

(use-package racket-mode 
  :mode "\\.rkt$"
  :interpreter "racket")

(use-package groovy-mode 
  :mode "\\.groovy"
  :interpreter "groovyclient"
  :config
  (require 'ob-groovy)
  (add-hook 'groovy-mode-hook (lambda () (fci-mode))))

(use-package ess
  :ensure nil
  :mode ("\\.r" . ess-mode)
  :interpreter "rterm.exe"
  :config 
    (require 'ess-site)  
    (setq inferior-R-program-name "c:/Program Files/R/R-3.2.5/bin/x64/Rterm.exe"))

(use-package scala-mode
  :mode "\\.scala"
  :interpreter "scala")

(use-package cc-mode 
  :mode "\\.c"
  :config
  (add-hook 'c-mode-hook (lambda () (fci-mode))))

(use-package restclient
  :mode (("\\.http$" . restclient-mode)))

(use-package lilypond-mode
  :disabled
  :load-path "site-lisp/lilypond/"
  :mode "\\.ly$"
  :config 
  (defun compile-ly ()
    (interactive)
    (save-buffer)
    (let ((pdf (concat (substring (buffer-name) 0 -3) ".pdf"))
          (ly (buffer-name)))
      (shell-command (concat "Lilypond.exe " ly))
   (when (get-buffer pdf) (kill-buffer pdf))
   (delete-other-windows)
   (find-file-other-window pdf)
   (find-file-other-window ly))))



(use-package web-mode
  :pin melpa-stable
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile helm zenburn-theme yasnippet web-mode use-package unicode-fonts undo-tree smartrep scala-mode rotate restclient racket-mode projectile powerline ox-reveal org-journal org-bullets ob-redis multiple-cursors htmlize highlight-tail helm-core groovy-mode fill-column-indicator expand-region epoch-view dash-functional chess chef-mode auto-complete anaphora))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
