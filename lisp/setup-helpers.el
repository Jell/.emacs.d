;; Always save even when buffer is not modified
(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))

;; Sublime-like click and make cursor
(defun control-meta-click (event)
  (interactive "e")
  (if (> (mc/num-cursors) 1)
      (multiple-cursors-mode 1)
    (multiple-cursors-mode 0))
  (mc/create-fake-cursor-at-point)
  (mouse-set-point event)
  (message (string (mc/num-cursors))))

;; Insert uuid
(defun insert-random-uuid ()
  (interactive)
  (insert
   (replace-regexp-in-string "\n$" ""
                             (shell-command-to-string "uuidgen"))))

(provide 'setup-helpers)
