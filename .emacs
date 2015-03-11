(set-register ?0 '(file . "~/.emacs"))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(load "~/.emacs.d/misc-settings.el")
(load "~/.emacs.d/misc-functions.el")
(load "~/.emacs.d/keybindings.el")
(load "~/.emacs.d/languages.el")
(load "~/.emacs.d/slack.el")
(load-theme 'tango t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(slack-buffer-name "*Slack*")
 '(speedbar-tag-hierarchy-method nil)
 '(speedbar-use-imenu-flag nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
