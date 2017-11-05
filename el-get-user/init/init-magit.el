;; full screen magit-status
(defun magit-lazy-status ()
  (interactive)

  (when (not (fboundp 'magit-status))
    (require 'magit)

    (defadvice magit-status (around magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
      (delete-other-windows))

    (defun magit-quit-session ()
      "Restores the previous window configuration and kills the magit buffer"
      (interactive)
      (kill-buffer)
      (jump-to-register :magit-fullscreen))

    (define-key magit-status-mode-map (kbd "q") 'magit-quit-session))

  (window-configuration-to-register :magit-fullscreen)
  (magit-status)
  (delete-other-windows))
