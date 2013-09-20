;;Configure Outbound Mail

;;Tell the program who you are

(setq user-full-name "Jean-Louis Giordano")
(setq user-mail-address "jean-louis@jawaninja.com")

;;Tell Emacs about your mail server and credentials

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(require 'smtpmail)

(provide 'setup-mail)
