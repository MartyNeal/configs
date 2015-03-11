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

(defun nuke-trailing-whitespace ()
  "Nuke all trailing whitespace in the buffer."
  (interactive)
  (cond ((interactive-p)
         (call-interactively 'whitespace-do-nuke-whitespace))
        (t
         (whitespace-do-nuke-whitespace)))
  nil)

(defun whitespace-do-nuke-whitespace ()
  (interactive)
  (let ((buffer-orig-read-only buffer-read-only)
        (buffer-read-only nil))
    (save-excursion
      (save-restriction
        (save-match-data
          (widen)
          (goto-char (point-min))
          (cond
           ((or (not buffer-orig-read-only)
                (interactive-p))
            (while (re-search-forward "[ \t]+$" (point-max) t)
              (delete-region (match-beginning 0) (match-end 0)))
            (goto-char (point-min))
            (and (re-search-forward "\n\n+\\'" nil t)
                 (delete-region (1+ (match-beginning 0)) (match-end 0))))
           (t
            (query-replace-regexp "[ \t]+$" "")
            (goto-char (point-min))
            (and (re-search-forward "\n\n+\\'" nil t)
                 (save-match-data
                   (y-or-n-p
                    "Delete excess trailing newlines at end of buffer? "))
                 (delete-region (1+ (match-beginning 0)) (match-end 0))))))))))

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
