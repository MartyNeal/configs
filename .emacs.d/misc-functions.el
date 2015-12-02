(defun chess-fics ()
  "Sets the username and password on login"
  (interactive)
  (require 'passwords "~/.emacs.d/passwords.el.gpg")
  (chess-ics "freechess.org" 5000 "cheeseheadtothe" fics-password))

(defun hilight-thing-at-point ()
  (interactive)
  (highlight-regexp (thing-at-point 'symbol)))
(global-set-key (kbd "C-x w w") 'hilight-thing-at-point)

(defun dired-do-shell-command-in-background (command)
  "In dired, do shell command in background on the file or directory named on this line."
  (interactive
   (list (dired-read-shell-command (concat "& on " "%s: ") nil (list (dired-get-filename)))))
  (call-process command nil 0 nil (dired-get-filename)))

(defun ascii-table ()
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

(defun untabify-buffer () (untabify (point-min) (point-max)))

(defun vc-compare-with-recent-version ()
  (interactive)
  (let ((cur-buf (current-buffer)))
    (vc-revision-other-window "")
    (setq ediff-split-window-function 'split-window-horizontally)
    (ediff-buffers cur-buf (current-buffer))))

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "jq ." (buffer-name) t)))

(advice-add 'chess :after
	    (lambda (&rest r)
	      (set-frame-size (selected-frame) 67 35)
	      (scroll-bar-mode 0)))

(defun toggle-frame-split ()
  "If the frame is split vertically, split it horizontally or vice versa.
Assumes that the frame is only split into two."
  (interactive)
  (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
  (let ((split-vertically-p (window-combined-p)))
    (delete-window) ; closes current window
    (if split-vertically-p
        (split-window-horizontally)
      (split-window-vertically)) ; gives us a split with the other window twice
    (switch-to-buffer nil))) ; restore the original window in this part of the frame
