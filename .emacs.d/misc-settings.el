(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-default 'truncate-lines t)

(set-frame-font "Consolas-12" nil t)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/cygdrive/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"
      chess-default-engine '(chess-stockfish chess-phalanx)
      chess-display-highlight-legal nil
      chess-images-default-size 64
      chess-stockfish-path "/cygdrive/c/Program Files/Scid-4.4/bin/engines/stockfish.exe"
      default-fill-column 80
      disabled-command-function nil
      frame-title-format '("%f" (dired-directory dired-directory "%b"))
      hscroll-margin 1
      indent-tabs-mode nil
      inhibit-splash-screen t
      inhibit-startup-message t
      initial-scratch-message ""
      jiralib-url "https://jira/"
      locale-coding-system 'utf-8
      mouse-yank-at-point t
      org-agenda-files '("/cygdrive/c/Users/nealm/notes.org" "/cygdrive/c/Users/nealm/todo.org")
      proced-auto-update-interval 1
      require-final-newline t
      scroll-conservatively 1
      scroll-margin 3
      scroll-preserve-screen-position t
      speedbar-tag-hierarchy-method nil
      speedbar-use-imenu-flag nil
      tab-width 4
      tramp-default-method "ssh"
      visible-bell t)

(column-number-mode 1)
(display-time-mode 1)
(global-font-lock-mode 1)
(global-hi-lock-mode 1)
(helm-mode 1)
(global-linum-mode 1)
(show-paren-mode 1)
(winner-mode 1)
(yas-global-mode 1)
(set-fringe-mode 0)
(menu-bar-mode 0)

(tool-bar-mode 0)
(ac-config-default)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(defalias 'yes-or-no-p 'y-or-n-p)
