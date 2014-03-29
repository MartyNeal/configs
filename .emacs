(set-register ?0 '(file . "~/.emacs"))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))
(package-initialize)

(load "~/.emacs.d/misc-settings.el")
(load "~/.emacs.d/misc-functions.el")
(load "~/.emacs.d/keybindings.el")
(load "~/.emacs.d/languages.el")
