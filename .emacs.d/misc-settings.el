(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'overwrite-mode 'disabled t)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-fill-column 80)
(setq hscroll-margin 1)
(setq indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq locale-coding-system 'utf-8)
(setq mouse-yank-at-point t)
(setq require-final-newline t)
(setq scroll-conservatively 1)
(setq scroll-margin 3)
(setq scroll-preserve-screen-position t)
(setq tab-width 4)
(setq visible-bell t)

(column-number-mode 1)
(display-time-mode 1)
(global-font-lock-mode 1)
(global-hi-lock-mode 1)
(show-paren-mode 1)
(menu-bar-mode 0)
(if (functionp 'set-fringe-mode) (set-fringe-mode 0))
(if (functionp 'tool-bar-mode) (tool-bar-mode 0))

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(defalias 'yes-or-no-p 'y-or-n-p)

(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

(defadvice scroll-down (around ewd-scroll-down first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

(custom-set-variables
 '(speedbar-tag-hierarchy-method nil)
 '(speedbar-use-imenu-flag nil))
(custom-set-faces)

;(set-frame-font "Consolas-14" nil t)
;(set-frame-font "Consolas-12" nil t)
(set-frame-font "monofur-15" nil t)
;(set-frame-font "monofur-14" nil t)
;(set-frame-font "monofur-12" nil t)
