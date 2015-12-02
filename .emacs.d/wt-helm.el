(require 'request)

(setq wt-helm-machines
      '(("hzoo04" . "hzoo04.staging.dmz")
	("hsapi03" . "hsapi03.staging.dmz")
	("hauth01" . "hauth01.staging.dmz")))

(defun wt-helm-action-source (candidate)
  `((name . ,(concat "Action on " candidate "?"))
    (candidates .
     ("healthcheck"
       "taillogs"
       ,@(cond
	  ((string-match "auth" candidate) '("getAuthToken"))
	  ((string-match "zoo" candidate) '("zkCli"))
	  ((string-match "sapi" candidate) '("start-stream")))))))

(setq wt-helm-machine-source
      `((name . "Machines")
        (candidates . ,wt-helm-machines)
        (action . (lambda (candidate)
		    (helm :sources (wt-helm-action-source candidate))))))

(helm :sources '(wt-helm-machine-source))

(defun healthcheck (server)
  (request
   (concat "http://" server ":8080/healthcheck")
   :parser (lambda () (shell-command-on-region 1 (point-max) "jq ." (get-buffer-create "*healthcheck*"))))
  t)

(defun taillogs (server)
  (require 'passwords ".emacs.d/passwords.el.gpg")
  (shell-command
   (concat
    "ssh.expect root " server " " staging-root-password
    " 'tail -f /var/log/webtrends/streamingapi/streaming.log'")))

(defun get-auth-token (server)
  )

(defun zkCli (server)
  )

(defun start-stream (server)
  )

(defun read-kafka-topic (server)
  )

(defun send-hit-scs (server)
  (request
   (concat "http://" server ":8080/healthcheck")
   :parser (lambda () (shell-command-on-region 1 (point-max) "jq ." (get-buffer-create "*healthcheck*"))))
  t)

(defun send-hit-lr (server)
  )
